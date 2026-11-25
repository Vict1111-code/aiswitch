# P0 transactional operation contracts
Review specification only. Trusted backend verifies identity and authorization; no direct browser execution. All routines are security invoker by default, with narrow grants to be designed. Lock order: workspace policy row, child/run or room as appropriate, reservation, then budget rows sorted by UUID. Never perform network calls while holding locks. Retry serialization/deadlock errors only with unchanged idempotency key.

| Operation | Atomic behavior | Failure / replay |
|---|---|---|
| reserve_budget | Lock workspace policy and child; derive every applicable scope from persisted run, room, project, actor and credential; verify currency/pricing; lock budgets sorted; reject excess; insert reservation, allocations, ledger and job together | Same child and request hash returns existing result; mismatched request conflicts; missing policy or unknown price fails closed |
| settle_usage | Lock child/reservation and allocated budgets; verify authenticated final usage evidence; deduplicate evidence key and hash; subtract holds and add canonical actual cost per scope; append ledger and usage | Unknown evidence retains hold; actual overrun recorded; duplicate no-op; conflicting evidence quarantined |
| release_reservation | Same lock order; require authoritative zero liability or proof no dispatch intent; subtract allocations; append release ledger | Never release ambiguous dispatch; duplicate no-op |
| reconcile_usage | Mark uncertain exposure without releasing; final evidence delegates to settlement/release; post-terminal corrections append signed delta | No reopening execution; unique evidence keys; late unexpected charge recorded |
| append_message | Verify active editor/owner and room ACL; lock room; dedup participant/client ID and request hash; allocate sequence; insert message, revision, event and outbox | Conflict on changed body; no event on replay; no AI invocation |
| consume_invite | Verify recipient identity and token hash; lock invite; check expiry/revocation; insert membership/project grant without escalating existing role; mark accepted | Single use; no membership resurrection without policy |
| consume_realtime_ticket | Match actor/workspace/token hash; check active membership and expiry; conditional consume | Exactly one winner; no raw token storage |
| claim_run_job | Lock eligible ready job with SKIP LOCKED; increment fence; set lease; check child state and dispatch intent | Expired post-intent job goes to reconciliation, never blind retry |
| renew_job_lease | Conditional update by job/fence/current unexpired lease | Stale worker rejected |
| revoke_context_source | Authorize owner/editor per ACL; lock source; mark revoked; record audit and invalidation event | Dispatch rechecks source state; already transmitted data cannot be recalled |

## Required transaction tests
TX-01 concurrent reserve race; TX-02 all-scope derivation cannot omit budget; TX-03 replay hash conflict; TX-04 unknown liability retained; TX-05 late charge after release; TX-06 settlement duplicate; TX-07 concurrent message sequence; TX-08 invite replay; TX-09 ticket replay; TX-10 stale fence; TX-11 expired post-intent lease; TX-12 revoke before dispatch; TX-13 cross-tenant access; TX-14 rollback on outbox failure. All planned.

## Implementation boundary
The SQL helper draft intentionally implements only ticket consumption and lease renewal; these are internal primitives, not complete authorization endpoints. Financial and other operations remain contracts until scope integrity, evidence identity, role grants and transaction tests are resolved. No routine is granted to browser roles.
