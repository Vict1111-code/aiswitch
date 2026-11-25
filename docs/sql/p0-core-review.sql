-- Review-only PostgreSQL draft; not a deployable migration.
begin;
create schema aiswitch;
revoke all on schema aiswitch from public;
create table aiswitch.workspaces (
 id uuid primary key default gen_random_uuid(), name text not null check(length(name)>0), created_at timestamptz not null default now()
);
create table aiswitch.memberships (
 workspace_id uuid references aiswitch.workspaces(id), user_id uuid not null,
 role text not null check(role in ('owner','editor','viewer')), active boolean not null default true,
 primary key(workspace_id,user_id)
);
create table aiswitch.projects (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null references aiswitch.workspaces(id),
 name text not null, revision bigint not null default 1 check(revision>0), archived_at timestamptz, unique(workspace_id,id)
);
create table aiswitch.rooms (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, project_id uuid not null,
 name text not null, next_seq bigint not null default 1 check(next_seq>0),
 unique(workspace_id,id), foreign key(workspace_id,project_id) references aiswitch.projects(workspace_id,id)
);
create table aiswitch.participants (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, room_id uuid not null,
 kind text not null check(kind in ('human','ai')), user_id uuid, model_ref text,
 check((kind='human' and user_id is not null and model_ref is null) or (kind='ai' and user_id is null and model_ref is not null)),
 unique(workspace_id,room_id,id), foreign key(workspace_id,room_id) references aiswitch.rooms(workspace_id,id),
 foreign key(workspace_id,user_id) references aiswitch.memberships(workspace_id,user_id)
);
create table aiswitch.messages (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, room_id uuid not null, participant_id uuid not null,
 client_id uuid not null, body text not null, revision bigint not null default 1 check(revision>0), created_at timestamptz not null default now(),
 unique(workspace_id,room_id,id), unique(room_id,participant_id,client_id),
 foreign key(workspace_id,room_id,participant_id) references aiswitch.participants(workspace_id,room_id,id)
);
create table aiswitch.room_events (
 workspace_id uuid not null, room_id uuid not null, seq bigint not null check(seq>0), event_id uuid not null unique,
 kind text not null, payload jsonb not null, primary key(room_id,seq),
 foreign key(workspace_id,room_id) references aiswitch.rooms(workspace_id,id)
);
create table aiswitch.outbox (
 event_id uuid primary key references aiswitch.room_events(event_id), available_at timestamptz not null default now(), published_at timestamptz, attempts integer not null default 0 check(attempts>=0)
);
create table aiswitch.runs (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, room_id uuid not null, initiator_id uuid not null,
 idempotency_key text not null, request_hash text not null, status text not null check(status in ('queued','running','completed','partial','failed','cancelled')), cancel_requested boolean not null default false,
 unique(workspace_id,id), unique(workspace_id,initiator_id,idempotency_key),
 foreign key(workspace_id,room_id) references aiswitch.rooms(workspace_id,id), foreign key(workspace_id,initiator_id) references aiswitch.memberships(workspace_id,user_id)
);
create table aiswitch.run_children (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, run_id uuid not null,
 status text not null check(status in ('queued','validating','reserved','running','completed','failed','cancel_requested','cancelled')),
 unique(workspace_id,id), foreign key(workspace_id,run_id) references aiswitch.runs(workspace_id,id)
);
create table aiswitch.budgets (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null references aiswitch.workspaces(id),
 scope_kind text not null check(scope_kind in ('workspace','project','room','user','credential')), scope_id uuid not null,
 currency text not null check(currency ~ '^[A-Z]{3}$'), period_start timestamptz not null, period_end timestamptz not null check(period_end>period_start),
 limit_amount numeric(24,8) not null check(limit_amount>=0), reserved_amount numeric(24,8) not null default 0 check(reserved_amount>=0), spent_amount numeric(24,8) not null default 0 check(spent_amount>=0),
 unique(workspace_id,id,currency), unique(workspace_id,scope_kind,scope_id,currency,period_start,period_end)
);
create table aiswitch.reservations (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, child_id uuid not null,
 currency text not null check(currency ~ '^[A-Z]{3}$'), amount numeric(24,8) not null check(amount>=0),
 status text not null check(status in ('pending','reserved','settled','released','reconciliation_required')),
 unique(workspace_id,id,currency), unique(child_id), foreign key(workspace_id,child_id) references aiswitch.run_children(workspace_id,id)
);
create table aiswitch.reservation_allocations (
 workspace_id uuid not null, reservation_id uuid not null, budget_id uuid not null, currency text not null,
 amount numeric(24,8) not null check(amount>=0), primary key(reservation_id,budget_id),
 foreign key(workspace_id,reservation_id,currency) references aiswitch.reservations(workspace_id,id,currency),
 foreign key(workspace_id,budget_id,currency) references aiswitch.budgets(workspace_id,id,currency)
);
create table aiswitch.usage_records (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, child_id uuid not null, event_key text not null,
 cost numeric(24,8) check(cost>=0), currency text not null check(currency ~ '^[A-Z]{3}$'),
 quality text not null check(quality in ('reported','estimated','unknown')),
 unique(child_id,event_key), foreign key(workspace_id,child_id) references aiswitch.run_children(workspace_id,id)
);
create index messages_room_time on aiswitch.messages(room_id,created_at,id);
create index outbox_pending on aiswitch.outbox(available_at) where published_at is null;
-- Deny all ordinary roles until narrowly scoped access policies and grants are reviewed.
do $$ declare t record; begin
 for t in select tablename from pg_tables where schemaname='aiswitch' loop
 execute format('alter table aiswitch.%I enable row level security',t.tablename);
 execute format('alter table aiswitch.%I force row level security',t.tablename);
 end loop;
end $$;
revoke all on all tables in schema aiswitch from public;
commit;
