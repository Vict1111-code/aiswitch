# Execution and financial state machines v1.0
Proposed normative transition contract for F01; supersedes gateway section 11 diagram. No runtime implementation.

## Execution
- queued → validating, cancelled
- validating → reserved, failed, cancelled
- reserved → running, failed, cancelled
- running → completed, failed, cancel_requested
- cancel_requested → completed, failed, cancelled
- completed → terminal
- failed → terminal
- cancelled → terminal
Use compare-and-swap revision and transactionally persist terminal event/outbox. Running means durable dispatch intent, not proof of provider acceptance. Cancellation is best effort: before intent, cancel and release with proof; after intent, request cancellation and retain financial exposure. Completion may win a cancellation race. Once terminal, execution outcome immutable; late usage remains accepted. Parent is queued until work starts, running while any child nonterminal, then completed if all completed, partial if some completed, failed if none completed and any failed, otherwise cancelled. Parent cancellation fans out only to nonterminal children. No implicit synthesis.

## Financial
- pending → reserved, released
- reserved → settled, released, reconciliation_required
- reconciliation_required → settled, released
- settled → terminal
- released → terminal
Financial pending is a conceptual state before reservation. Reserve all applicable scopes atomically in deterministic budget-ID order, same currency, nonnegative decimal amounts. Reject if any cap exceeded. Release only with authoritative evidence of zero liability (including proven no dispatch). Unknown usage retains reservation in reconciliation_required. Settlement records actual canonical cost, releases held allocations and adds actual to each applicable budget; never sum allocations as actual cost. Actual overrun recorded, future excess blocked. Corrections after settlement or release are append-only compensating ledger events with unique evidence keys, not reopening execution; unexpected late charges must be recorded even after release. Unknown pricing blocks capped paid dispatch. No external provider hard-cap guarantee.

## Dispatch and recovery
Persist job and reservation atomically; lease job with monotonically increasing fencing token, heartbeat, compare-and-swap writes. Recheck ACL, credential version, consent, context revision and budget before dispatch intent. Persist intent before external call; crash between intent and send is ambiguous, not proof of no charge. Retry pre-intent failures only with bounded backoff and unchanged authorization; after intent retry only if provider-specific idempotency guarantees verified and reservation covers liability. Otherwise mark execution failed (or cancelled if cancellation confirmed) and accounting reconciliation_required; do not silently switch payer. Late worker writes rejected by fencing, but authenticated usage evidence may enter independent reconciliation path. No network call inside budget lock transaction. Durable stream events dedup by child/sequence; terminal and outbox commit together. Provider cancellation/usage capabilities require adapter-specific validation.

## Planned acceptance cases
| ID | Scenario | Expected |
|---|---|---|
| SM-01 | queued cancellation | cancelled; pending reservation released |
| SM-02 | pre-dispatch authorization revoked | failed; release only if no dispatch proven |
| SM-03 | worker crash after dispatch intent | no blind retry; reconciliation_required |
| SM-04 | one child cancelled | siblings unaffected |
| SM-05 | late provider usage after cancellation | settle without changing execution terminal |
| SM-06 | duplicate usage event | no second ledger mutation |
| SM-07 | concurrent budget reservations | all scopes locked; reject excess |
| SM-08 | actual exceeds estimate | record actual; block future excess |
| SM-09 | completion races cancellation | first committed terminal wins; late usage still accepted |
| SM-10 | expired worker lease | fencing token rejects stale worker writes |
| SM-11 | unknown price | reject capped paid dispatch |
| SM-12 | same idempotency key different hash | 409; no dispatch |
| SM-13 | all children terminal mixed outcomes | parent partial if any completed, otherwise failed if any failed, else cancelled |
| SM-14 | reconciliation without evidence | retain reservation |
| SM-15 | late correction after settlement | append compensating ledger entry; no duplicate canonical cost |
| SM-16 | replayed terminal event | one durable terminal, transport dedup |

## Implementation gaps
Physical DDL must add dispatch intent, job lease/fence, run revision, immutable ledger and canonical usage correction semantics; parent aggregation and typed SSE need implementation. JSON transition registry is a review artifact, not an executable engine. Tests above are planned, not run.

## Parent aggregate clarification
Parent status is queued/running/completed/partial/failed/cancelled only. Cancellation request is an independent boolean, not an aggregate state. Queued may transition directly to terminal when all children terminate before dispatch. Running begins when any child starts processing; never regress to queued. API and review SQL aligned. Runtime enforcement pending.
