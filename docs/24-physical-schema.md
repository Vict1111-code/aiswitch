# Physical schema review

Draft only; docs/sql/p0-core-review.sql contains 14 core tables. Not a CLI migration or applied schema. No SQL parser or database execution performed. Private schema, deny-default RLS, no client grants. Backend role and policy design pending. Identity user IDs are placeholders pending auth integration. Model refs are provisional; no credential storage yet.

## Migration sequence
1. Identity and memberships, profiles/auth FK, project ACL and invites.
2. Rooms, participants, messages, revisions, room events and outbox; transactional sequence allocation.
3. Provider catalog, custom endpoints/models, credential metadata and separate encrypted vault with versioned ciphertext, nonce, wrapped key and KMS reference; no plaintext.
4. Context sources/revisions/grants/manifests, consent and deletion lifecycle.
5. Runs/children/jobs, composite participant/model/credential/manifest bindings, idempotency and leases.
6. Budgets, reservations, allocations, usage, immutable ledger, pricing units and credit expiry; validate polymorphic scope and nonoverlapping periods. Atomic reservation/settlement functions required; draft tables alone do not enforce caps.
7. Prompts, activity, audit, tickets and retention.
8. Narrow role grants and RLS policies, deny-default from first creation; test with non-owner roles, never service-role bypass as proof.

## Gates
DB-01–12 from logical design; add cross-room child binding, currency mismatch, overlapping budgets, late usage, revoked consent, ticket replay and vault access. Fresh install and upgrade on disposable PostgreSQL/Supabase only after toolchain selection. No live project changes. Remaining DDL includes all omitted P0 entities, FK/index completeness, immutable ledger enforcement, role grants and transaction routines. Generate actual migration filenames using selected CLI at implementation time. F01 remains open.
