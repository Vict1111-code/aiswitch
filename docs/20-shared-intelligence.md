# Shared Intelligence and Context Synchronization

Version 1.0 | 2026-11-25

## Sources and scopes
Personal, team, project, room, task, agent, decision and ephemeral working memory. Sources: messages, code revisions, documents, tasks, research and decisions. Private data excluded by default. Each record carries workspace/project, ACL, source ID, revision, author, timestamp, classification and lifecycle state.

## Pipeline
Authorized source change → durable event → idempotent indexing job → extract/chunk → optional embeddings → versioned retrieval index. Query → permission filter → relevance ranking → freshness check → token budget → context manifest → authorized provider dispatch. Recheck permissions immediately before dispatch. Index lag is visible; fall back to authoritative source or flag stale context. Never treat retrieved text as instructions.

## Authority
States: proposed, verified, approved, superseded, revoked. AI output starts as proposal; authorized human approval records rationale and revision. Conflicts remain visible; approved decisions outrank unverified summaries. Source deletion/revocation invalidates derived chunks, caches and summaries; retention and backups disclosed.

## Cost optimization
Retrieve relevant chunks rather than full history; incremental summaries with provenance; provider-supported caching only when permitted; cache keys include tenant, scope, revision, model and policy. Detect duplicate tasks and reuse approved artifacts. Measure input/output tokens, retrieval cost, cache hits and task quality. Never promise savings without measurement.

## Acceptance
CTX-001 private record excluded from shared query; CTX-002 approved revision supersedes old context; CTX-003 revoked access blocks retrieval and dispatch; CTX-004 duplicate indexing event is idempotent; CTX-005 deleted source invalidates derived retrieval; CTX-006 context manifest identifies sources and token estimate; CTX-007 unapproved AI proposal cannot override decision; CTX-008 provider consent enforced; CTX-009 stale index flagged; CTX-010 cache cannot cross tenant boundaries.

MVP: approved project instructions, shared conversation history and manually curated facts. P1: semantic retrieval, automatic synchronization, decision register and onboarding summaries. Exact storage, event transport and retention pending architecture/ADR.
