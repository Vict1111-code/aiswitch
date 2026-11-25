# AISwitch — Architecture Decision Records

Version 1.0 | 2026-11-25

All decisions are **Proposed**, not accepted or implemented. Review before scaffolding; record acceptance date, reviewer and superseding ADR rather than silently rewriting history. Based on SAD, HAC, gateway, database and API baselines. Alternatives are qualitative engineering assessments, not benchmark results.

## ADR-001 — Web client
- Status: Proposed
- Context: Web client must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Vite SPA; Vue.
- Decision: Next.js/React/TypeScript/Tailwind.
- Rationale: Shared UI ecosystem and typed clients; SSR optional.
- Consequences: Framework complexity; avoid server-only business logic.
- Acceptance evidence required: Build chat/settings prototype; accessibility and bundle checks.

## ADR-002 — Backend
- Status: Proposed
- Context: Backend must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Go; Node/NestJS.
- Decision: FastAPI/Python.
- Rationale: Async streaming and Python AI ecosystem.
- Consequences: Runtime typing and concurrency discipline.
- Acceptance evidence required: Mock two simultaneous streams; typecheck and load test.

## ADR-003 — Architecture
- Status: Proposed
- Context: Architecture must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Microservices; single process.
- Decision: Modular monolith plus trusted workers.
- Rationale: Low operational overhead with explicit boundaries.
- Consequences: Shared release coupling; enforce module interfaces.
- Acceptance evidence required: Dependency checks and worker crash recovery.

## ADR-004 — Database and identity
- Status: Proposed
- Context: Database and identity must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Self-managed Postgres and identity; Firebase.
- Decision: Postgres with Supabase Auth/Storage.
- Rationale: Relational transactions, tenant integrity and managed auth.
- Consequences: Vendor dependencies; service role bypass.
- Acceptance evidence required: Cross-tenant RLS tests, JWT revocation, backup restore.

## ADR-005 — Realtime
- Status: Proposed
- Context: Realtime must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Polling; all WebSocket; managed realtime.
- Decision: REST writes, WebSocket rooms, SSE private runs.
- Rationale: Separate durable collaboration from model streams.
- Consequences: Two transports and reconnect logic.
- Acceptance evidence required: Two clients, replay, revoke and slow consumer tests.

## ADR-006 — Durable jobs
- Status: Proposed
- Context: Durable jobs must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Redis-only queue; managed broker.
- Decision: Postgres job/outbox authority; Redis wakeup/fanout.
- Rationale: Recover after transient queue loss; atomic persistence.
- Consequences: Polling and lease complexity.
- Acceptance evidence required: Crash before/after dispatch; Redis loss; no duplicate billing.

## ADR-007 — Credentials
- Status: Proposed
- Context: Credentials must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Plain DB secrets; managed vault only.
- Decision: Envelope encryption with external KMS; scoped resolver.
- Rationale: Versioned encrypted keys and narrow trust boundary.
- Consequences: KMS costs and rotation operations.
- Acceptance evidence required: Secret redaction, rotation, revocation and key recovery.

## ADR-008 — Provider adapters
- Status: Proposed
- Context: Provider adapters must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: LiteLLM only; direct SDK calls everywhere.
- Decision: Native OpenAI/Anthropic plus compatible adapter.
- Rationale: Explicit capabilities and normalized contracts.
- Consequences: Adapter maintenance; evaluate LiteLLM behind port.
- Acceptance evidence required: Mock fixtures and opt-in capped live tests.

## ADR-009 — Financial accounting
- Status: Proposed
- Context: Financial accounting must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Redis counters; post-hoc tracking.
- Decision: Postgres atomic multi-scope reservations and immutable ledger.
- Rationale: Concurrent team spending control and auditability.
- Consequences: Lock contention; unknown provider charges.
- Acceptance evidence required: Budget race, settlement replay and late usage.

## ADR-010 — Shared context
- Status: Proposed
- Context: Shared context must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Full transcript every call; external vector DB.
- Decision: Curated versioned sources P0; pgvector candidate P1.
- Rationale: Reduce repeated tokens while preserving provenance.
- Consequences: Retrieval quality and invalidation complexity.
- Acceptance evidence required: ACL before ranking, deletion and relevance evaluation.

## ADR-011 — Collaborative editing
- Status: Proposed
- Context: Collaborative editing must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: OT; exclusive locks.
- Decision: Yjs CRDT candidate P1 plus Git checkpoints.
- Rationale: Concurrent human editing and offline convergence.
- Consequences: Semantic conflicts remain; persistence overhead.
- Acceptance evidence required: Convergence, ACL, stale AI patch and restore tests.

## ADR-012 — Sandbox
- Status: Proposed
- Context: Sandbox must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Ordinary shared container; host shell.
- Decision: Separate disposable isolated runtime P1; evaluate microVM or hardened sandbox.
- Rationale: Untrusted code cannot access control plane or vault.
- Consequences: Compute cost and startup latency.
- Acceptance evidence required: Escape threat model, egress, quotas and teardown tests.

## ADR-013 — Deployment
- Status: Proposed
- Context: Deployment must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: All serverless; single VPS; Kubernetes.
- Decision: Vercel web candidate; long-lived container API/workers; managed DB.
- Rationale: Streaming support with low initial operations.
- Consequences: Multiple vendors; costs and region latency.
- Acceptance evidence required: Measure streaming limits, monthly cost, recovery and deploy rollback.

## ADR-014 — Observability
- Status: Proposed
- Context: Observability must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Vendor-only instrumentation; raw prompt logs.
- Decision: OpenTelemetry with redacted structured logs.
- Rationale: Portable tracing without secret/prompt exposure.
- Consequences: Instrumentation effort and storage cost.
- Acceptance evidence required: Trace child runs; verify redaction and alert delivery.

## ADR-015 — API contracts
- Status: Proposed
- Context: API contracts must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: GraphQL only; undocumented RPC.
- Decision: OpenAPI 3.1 REST; typed SSE; later AsyncAPI.
- Rationale: Generated clients and explicit resource contracts.
- Consequences: Schema maintenance; event versioning.
- Acceptance evidence required: Lint, client generation, contract tests and compatibility checks.

## ADR-016 — Repository and CI
- Status: Proposed
- Context: Repository and CI must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Polyrepo; direct master changes.
- Decision: Monorepo, GitHub issues/PRs, mocked provider CI.
- Rationale: Unified context and review; no default paid calls.
- Consequences: CI scope and ownership complexity.
- Acceptance evidence required: Protected branch review, lint, tests and secret scan.

## ADR-017 — Agent orchestration
- Status: Proposed
- Context: Agent orchestration must satisfy collaboration, security, affordability and maintainability within phased scope.
- Alternatives: Unbounded agent loops; framework-first.
- Decision: Durable explicit state machine; evaluate LangGraph later.
- Rationale: Approval, cost and retry control.
- Consequences: More explicit workflow code.
- Acceptance evidence required: Approval replay, pause/resume and ambiguous dispatch tests.

## Cross-cutting gates
P0 collaboration and BYOK first; P1 editing/sandbox/retrieval; P2 advanced agents. No production provisioning or paid API calls before explicit implementation gate. Exact versions, hosting provider, KMS vendor, Redis library, retention, quotas, pricing, local bridge and sandbox technology remain open. Reconcile SRS team/group priorities and event naming, complete OpenAPI gaps, and refine physical schema before implementation. Review cost estimates with actual pilot workload. No benchmarks or security tests performed.
