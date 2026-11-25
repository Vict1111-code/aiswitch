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

## Expanded review DDL (Phase 1.6B)
39 tables in one transactional review file; all remain deny-default with forced RLS and no public grants. Added identity/profile placeholders, project ACL, invitations, providers, custom endpoints/models, encrypted credential versions and grants, consent, curated context manifests, pricing, jobs, credit observations, ledger, prompts, activity, audit, tickets and message revisions. Added child-room/participant composite FKs and append-only triggers for pricing and ledger. This is not a deployed migration. HTTPS check alone is not SSRF protection. Credential ciphertext fields are not encryption implementation. Remaining critical gaps: auth binding, separate vault role/schema, project/room privacy and explicit policies, model/pricing/credential/manifest destination consistency, typed budget scope and overlapping periods, atomic reserve/settle and ticket/invite consumption, message sequence transaction, deletion retention, complete immutable usage/correction semantics, executable SQL validation. No SQL executed. B02 remains open.
