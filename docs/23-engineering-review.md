# F01 engineering decision review — 2026-11-25

Status: recommendation for maintainer review; no ADR acceptance or runtime validation claimed.

| ADR | Recommendation | Gate |
|---|---|---|
| 001 | Adopt Next.js/React/TS for prototype | F02 build, F09 accessibility |
| 002 | Adopt FastAPI/Python for prototype | F02 typecheck, F08 concurrent streams |
| 003 | Adopt modular monolith and separate trusted worker | F02 boundaries, F08 recovery |
| 004 | Adopt PostgreSQL and Supabase identity candidate | F03 RLS and restore |
| 005 | Adopt REST + room WebSocket + run SSE | F06 reconnect/revoke |
| 006 | Adopt durable PostgreSQL jobs; Redis optional wakeup until needed | F08 crash and Redis loss |
| 007 | Adopt envelope encryption design; defer KMS vendor | F04 rotation and redaction |
| 008 | Adopt native adapters behind interface | F08 mock contracts |
| 009 | Adopt atomic reservations and immutable ledger | F05 concurrency and reconciliation |
| 010 | Adopt curated context P0; defer vector choice P1 | F07 ACL and deletion |
| 011 | Defer Yjs selection until P1 prototype | F13 convergence |
| 012 | Defer sandbox runtime selection; require isolation | F13 threat model |
| 013 | Defer production hosting selection | F10 cost and latency |
| 014 | Adopt redacted telemetry design | F02/F08 redaction |
| 015 | Adopt OpenAPI 3.1 and typed event contracts | F01 lint and client generation |
| 016 | Adopt monorepo and PR workflow | F02 CI |
| 017 | Adopt bounded state-machine principle; defer framework | F15 approval tests |

Recommendations are not measured benchmarks. Maintainer acceptance and evidence must be recorded separately. Local-first mocked development; no live paid calls, no production provisioning.

## F01 remaining work
1. Complete typed API schemas, project binding, invite proof, one-use WebSocket tickets, custom endpoint and manual model routes.
2. Define physical migration contracts and tenant composite keys, pricing units, credit expiry and reconciliation integrity.
3. Separate execution and accounting states: execution terminal outcomes completed/failed/cancelled; financial reservation states reserved/released/settled/reconciliation_required. Cancellation does not imply release; uncertain dispatch remains reserved until reconciliation. No blind retry.
4. Map P0 requirements to issue and test IDs, including curated context deletion/revocation; defer vector indexing tests.
5. Run independent OpenAPI lint and contract checks; record results. Review ADR recommendations with maintainer before F02. Do not close F01 until gates pass or explicit deferrals recorded.
