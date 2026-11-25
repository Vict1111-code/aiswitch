-- Disposable database only. All fixture changes rolled back.
begin;
do $test$
declare w uuid := gen_random_uuid(); u uuid := gen_random_uuid(); w2 uuid := gen_random_uuid(); t uuid; n integer;
begin
 select count(*) into n from pg_tables where schemaname in ('aiswitch','aiswitch_vault');
 if n <> 39 then raise exception 'expected 39 tables, got %',n; end if;
 if exists(select 1 from pg_class c join pg_namespace s on s.oid=c.relnamespace where s.nspname in ('aiswitch','aiswitch_vault') and c.relkind='r' and not(c.relrowsecurity and c.relforcerowsecurity)) then raise exception 'RLS flags missing'; end if;
 insert into aiswitch.workspaces(id,name) values(w,'test'),(w2,'other');
 insert into aiswitch.profiles(id,display_name) values(u,'test');
 insert into aiswitch.memberships(workspace_id,user_id,role) values(w,u,'owner');
 insert into aiswitch.budgets(workspace_id,scope_kind,scope_id,currency,period_start,period_end,limit_amount) values(w,'workspace',w,'USD','2026-01-01','2026-02-01',10),(w,'workspace',w,'USD','2026-02-01','2026-03-01',10);
 begin
 insert into aiswitch.budgets(workspace_id,scope_kind,scope_id,currency,period_start,period_end,limit_amount) values(w,'workspace',w,'USD','2026-01-15','2026-02-15',10);
 raise exception 'overlap accepted';
 exception when exclusion_violation then null; end;
 begin
 insert into aiswitch.budgets(workspace_id,scope_kind,scope_id,currency,period_start,period_end,limit_amount) values(w,'workspace',w2,'USD','2026-01-01','2026-02-01',10);
 raise exception 'cross workspace scope accepted';
 exception when check_violation then null; end;
 insert into aiswitch.realtime_tickets(workspace_id,user_id,token_hash,expires_at) values(w,u,decode('abcd','hex'),clock_timestamp()+interval '1 minute') returning id into t;
 if aiswitch.consume_realtime_ticket(w,u,decode('abcd','hex')) is distinct from t then raise exception 'ticket failed'; end if;
 if aiswitch.consume_realtime_ticket(w,u,decode('abcd','hex')) is not null then raise exception 'ticket replay accepted'; end if;
end;
$test$;
rollback;
