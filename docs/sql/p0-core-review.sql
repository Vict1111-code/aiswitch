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
-- Additional P0 review tables. Identity adapter must bind profiles to verified auth identities.
create table aiswitch.profiles (id uuid primary key, display_name text not null);
alter table aiswitch.memberships add foreign key(user_id) references aiswitch.profiles(id);
create table aiswitch.project_members (
 workspace_id uuid not null, project_id uuid not null, user_id uuid not null, role text not null check(role in ('owner','editor','viewer')),
 primary key(workspace_id,project_id,user_id), foreign key(workspace_id,project_id) references aiswitch.projects(workspace_id,id),
 foreign key(workspace_id,user_id) references aiswitch.memberships(workspace_id,user_id));
create table aiswitch.invites (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null references aiswitch.workspaces(id), project_id uuid,
 email_hash bytea not null, token_hash bytea not null unique, role text not null check(role in ('editor','viewer')),
 expires_at timestamptz not null, accepted_at timestamptz, revoked_at timestamptz,
 foreign key(workspace_id,project_id) references aiswitch.projects(workspace_id,id));
create table aiswitch.providers (id uuid primary key default gen_random_uuid(), slug text not null unique, adapter_type text not null, enabled boolean not null default true);
create table aiswitch.custom_endpoints (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, owner_id uuid not null, provider_id uuid not null references aiswitch.providers(id),
 base_url text not null check(base_url like 'https://%'), enabled boolean not null default true,
 unique(workspace_id,id), unique(workspace_id,id,provider_id), foreign key(workspace_id,owner_id) references aiswitch.memberships(workspace_id,user_id));
create table aiswitch.models (id uuid primary key default gen_random_uuid(), provider_id uuid not null references aiswitch.providers(id), external_id text not null, capabilities jsonb not null default '{}', enabled boolean not null default true, unique(provider_id,external_id));
create table aiswitch.custom_models (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, endpoint_id uuid not null, external_id text not null, capabilities jsonb not null default '{}',
 unique(workspace_id,id), unique(endpoint_id,external_id), foreign key(workspace_id,endpoint_id) references aiswitch.custom_endpoints(workspace_id,id));
create table aiswitch.provider_credentials (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, owner_id uuid not null, provider_id uuid not null references aiswitch.providers(id), endpoint_id uuid,
 alias text not null, visibility text not null default 'personal' check(visibility in ('personal','shared')), status text not null check(status in ('unverified','active','invalid','disabled','revoked')),
 unique(workspace_id,id), foreign key(workspace_id,owner_id) references aiswitch.memberships(workspace_id,user_id),
 foreign key(workspace_id,endpoint_id,provider_id) references aiswitch.custom_endpoints(workspace_id,id,provider_id));
create table aiswitch.credential_versions (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, credential_id uuid not null, version integer not null check(version>0),
 ciphertext bytea not null, wrapped_key bytea not null, nonce bytea not null, kms_ref text not null, revoked_at timestamptz,
 unique(workspace_id,id), unique(credential_id,version), foreign key(workspace_id,credential_id) references aiswitch.provider_credentials(workspace_id,id));
create table aiswitch.credential_grants (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, credential_id uuid not null, user_id uuid not null, project_id uuid not null, expires_at timestamptz, revoked_at timestamptz,
 foreign key(workspace_id,credential_id) references aiswitch.provider_credentials(workspace_id,id),
 foreign key(workspace_id,project_id,user_id) references aiswitch.project_members(workspace_id,project_id,user_id));
create table aiswitch.provider_consents (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, project_id uuid not null, user_id uuid not null, provider_id uuid not null references aiswitch.providers(id), endpoint_id uuid,
 scope jsonb not null, expires_at timestamptz, revoked_at timestamptz, unique(workspace_id,id),
 foreign key(workspace_id,project_id,user_id) references aiswitch.project_members(workspace_id,project_id,user_id),
 foreign key(workspace_id,endpoint_id,provider_id) references aiswitch.custom_endpoints(workspace_id,id,provider_id));
create table aiswitch.context_sources (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, project_id uuid not null, owner_id uuid not null,
 visibility text not null check(visibility in ('private','shared')), kind text not null, revoked_at timestamptz,
 unique(workspace_id,id), foreign key(workspace_id,project_id,owner_id) references aiswitch.project_members(workspace_id,project_id,user_id));
create table aiswitch.source_revisions (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, source_id uuid not null, revision bigint not null check(revision>0),
 content_ref text, content_hash text not null, created_at timestamptz not null default now(), unique(workspace_id,id), unique(source_id,revision),
 foreign key(workspace_id,source_id) references aiswitch.context_sources(workspace_id,id));
create table aiswitch.source_grants (
 workspace_id uuid not null, source_id uuid not null, user_id uuid not null, primary key(source_id,user_id),
 foreign key(workspace_id,source_id) references aiswitch.context_sources(workspace_id,id), foreign key(workspace_id,user_id) references aiswitch.memberships(workspace_id,user_id));
create table aiswitch.context_manifests (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, consent_id uuid not null, token_estimate bigint not null check(token_estimate>=0),
 unique(workspace_id,id), foreign key(workspace_id,consent_id) references aiswitch.provider_consents(workspace_id,id));
create table aiswitch.manifest_items (
 workspace_id uuid not null, manifest_id uuid not null, revision_id uuid not null, ordinal integer not null check(ordinal>=0),
 primary key(manifest_id,ordinal), foreign key(workspace_id,manifest_id) references aiswitch.context_manifests(workspace_id,id),
 foreign key(workspace_id,revision_id) references aiswitch.source_revisions(workspace_id,id));
create table aiswitch.model_pricing (
 id uuid primary key default gen_random_uuid(), workspace_id uuid, model_id uuid references aiswitch.models(id), custom_model_id uuid,
 currency text not null check(currency ~ '^[A-Z]{3}$'), input_rate numeric(24,8) not null check(input_rate>=0), output_rate numeric(24,8) not null check(output_rate>=0),
 token_unit integer not null check(token_unit>0), effective_at timestamptz not null,
 check((model_id is not null and custom_model_id is null and workspace_id is null) or (model_id is null and custom_model_id is not null and workspace_id is not null)),
 foreign key(workspace_id,custom_model_id) references aiswitch.custom_models(workspace_id,id));
alter table aiswitch.runs add unique(workspace_id,room_id,id);
alter table aiswitch.run_children add column room_id uuid not null, add column participant_id uuid not null, add column credential_version_id uuid not null,
 add column manifest_id uuid not null, add column pricing_id uuid references aiswitch.model_pricing(id), add column revision bigint not null default 1 check(revision>0),
 add column dispatch_intent_at timestamptz,
 add foreign key(workspace_id,room_id,run_id) references aiswitch.runs(workspace_id,room_id,id),
 add foreign key(workspace_id,room_id,participant_id) references aiswitch.participants(workspace_id,room_id,id),
 add foreign key(workspace_id,credential_version_id) references aiswitch.credential_versions(workspace_id,id),
 add foreign key(workspace_id,manifest_id) references aiswitch.context_manifests(workspace_id,id);
create table aiswitch.run_jobs (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, child_id uuid not null, state text not null check(state in ('ready','leased','done','dead')),
 fence bigint not null default 0 check(fence>=0), lease_until timestamptz, available_at timestamptz not null default now(),
 unique(child_id), foreign key(workspace_id,child_id) references aiswitch.run_children(workspace_id,id));
create table aiswitch.credit_records (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, credential_id uuid not null, currency text not null check(currency ~ '^[A-Z]{3}$'),
 amount numeric(24,8) not null check(amount>=0), observed_at timestamptz not null, expires_at timestamptz,
 foreign key(workspace_id,credential_id) references aiswitch.provider_credentials(workspace_id,id));
create table aiswitch.ledger_events (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, reservation_id uuid not null, budget_id uuid not null, currency text not null,
 event_key text not null, kind text not null check(kind in ('reserve','release','settle','correction')), amount numeric(24,8) not null,
 created_at timestamptz not null default now(), unique(workspace_id,event_key,budget_id),
 foreign key(workspace_id,reservation_id,currency) references aiswitch.reservations(workspace_id,id,currency),
 foreign key(workspace_id,budget_id,currency) references aiswitch.budgets(workspace_id,id,currency));
create table aiswitch.prompt_templates (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, owner_id uuid not null, visibility text not null check(visibility in ('private','shared')), body text not null, version bigint not null default 1,
 foreign key(workspace_id,owner_id) references aiswitch.memberships(workspace_id,user_id));
create table aiswitch.activity_events (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, actor_id uuid not null, kind text not null, target_ref text not null, created_at timestamptz not null default now(),
 foreign key(workspace_id,actor_id) references aiswitch.memberships(workspace_id,user_id));
create table aiswitch.audit_logs (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null references aiswitch.workspaces(id), actor_id uuid, action text not null, target_ref text not null, trace_id text not null, created_at timestamptz not null default now());
create table aiswitch.realtime_tickets (
 id uuid primary key default gen_random_uuid(), workspace_id uuid not null, user_id uuid not null, token_hash bytea not null unique, expires_at timestamptz not null, consumed_at timestamptz,
 foreign key(workspace_id,user_id) references aiswitch.memberships(workspace_id,user_id));
create table aiswitch.message_revisions (
 workspace_id uuid not null, room_id uuid not null, message_id uuid not null, revision bigint not null check(revision>0), body text, created_at timestamptz not null default now(),
 primary key(message_id,revision), foreign key(workspace_id,room_id,message_id) references aiswitch.messages(workspace_id,room_id,id));
alter table aiswitch.messages add column deleted_at timestamptz;
create index run_jobs_ready on aiswitch.run_jobs(state,available_at,lease_until);
create index source_revisions_latest on aiswitch.source_revisions(source_id,revision desc);
-- No client grants. Append-only triggers are defense in depth, not protection against database administrators.
create function aiswitch.reject_mutation() returns trigger language plpgsql security invoker set search_path=pg_catalog as $fn$ begin raise exception 'append-only record'; end; $fn$;
revoke all on function aiswitch.reject_mutation() from public;
create trigger ledger_append_only before update or delete on aiswitch.ledger_events for each row execute function aiswitch.reject_mutation();
create trigger pricing_append_only before update or delete on aiswitch.model_pricing for each row execute function aiswitch.reject_mutation();

-- Deny all ordinary roles until narrowly scoped access policies and grants are reviewed.
do $$ declare t record; begin
 for t in select tablename from pg_tables where schemaname='aiswitch' loop
 execute format('alter table aiswitch.%I enable row level security',t.tablename);
 execute format('alter table aiswitch.%I force row level security',t.tablename);
 end loop;
end $$;
revoke all on all tables in schema aiswitch from public;
commit;
