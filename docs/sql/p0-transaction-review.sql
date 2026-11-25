-- Review-only internal primitives; apply only after core review schema in disposable DB.
begin;
create function aiswitch.consume_realtime_ticket(p_workspace uuid,p_user uuid,p_hash bytea)
returns uuid language sql security invoker set search_path=pg_catalog as $fn$
 update aiswitch.realtime_tickets t set consumed_at=clock_timestamp()
 where t.workspace_id=p_workspace and t.user_id=p_user and t.token_hash=p_hash
 and t.consumed_at is null and t.expires_at>clock_timestamp()
 and exists(select 1 from aiswitch.memberships m where m.workspace_id=t.workspace_id and m.user_id=t.user_id and m.active)
 returning t.id;
$fn$;
create function aiswitch.renew_job_lease(p_workspace uuid,p_job uuid,p_fence bigint,p_seconds integer)
returns timestamptz language sql security invoker set search_path=pg_catalog as $fn$
 update aiswitch.run_jobs j set lease_until=clock_timestamp()+make_interval(secs=>p_seconds)
 where j.workspace_id=p_workspace and j.id=p_job and j.fence=p_fence and j.state='leased'
 and j.lease_until>clock_timestamp() and p_seconds between 1 and 300
 returning j.lease_until;
$fn$;
revoke all on function aiswitch.consume_realtime_ticket(uuid,uuid,bytea) from public;
revoke all on function aiswitch.renew_job_lease(uuid,uuid,bigint,integer) from public;
commit;
