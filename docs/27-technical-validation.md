# F01 static technical validation — 2026-11-25

Separate readback checks against committed artifacts, not independent third-party conformance validation.

| Check | Result |
|---|---|
| OpenAPI JSON parsing | Pass |
| Operations / schemas | 54 / 62 |
| Required path parameters | Pass, all 54 operations |
| Top-level required property definitions | Pass |
| Component schema references | 0 missing |
| State transition destinations | 0 undefined |
| Traceability identifiers | Initially 166/170; four SRS-HAC IDs omitted by parser; corrected to 170/170 |
| SQL table inventory | 14 tables; lexical inspection only |
| External OpenAPI validator, generated client | Not run |
| PostgreSQL parser, migration execution, RLS tests | Not run |
| Repository-wide link crawl | Not run |

## Remaining blockers
- B01: full OpenAPI conformance, typed event payloads, consent scope, pagination, remaining CRUD and response contracts.
- B02: physical DDL incomplete; project ACL, auth FK, vault, model bindings, context, durable jobs, ledger and atomic procedures absent. No SQL runtime evidence.
- B03: parent execution enum permits validating/reserved/cancel_requested while aggregation prose only defines queued/running/terminal; reconcile before implementation. Child and financial enum names align but transitions are not runtime enforced.
- B04: traceability now covers enumerated IDs, not all PRD clauses/NFRs/API/DB cases. Mixed priorities and proposed CTX deferrals require review.
- B05: ADRs remain proposed; no formal acceptance or provider validation.
- B06: full link validation and external conformance tools not run.
- B07: gateway section replacement and documentation index require final readback.

F01 is blocked. Do not close or merge as implementation-ready. Next resolve B01–B05 or record explicit scoped deferrals; run actual validators on disposable environment. No paid calls or provisioning.
