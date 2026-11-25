# AISwitch — Software Requirements Specification

Version 1.2 | 2026-11-25 | Proposed engineering baseline

## 1. Purpose and scope
Derived from [PRD v1.3](02-prd.md) and [multi-model specification](18-multi-model-chat.md). P0 is personal and small-team web MVP; P1 core engineering; P2 advanced; P3 future. This document specifies observable behavior, not verified implementation. P3 features retain PRD scope and require later detailed specifications.

## 2. Actors and boundaries
Guest, authenticated user, workspace member/admin, system worker, external provider and sandbox. All external content and model outputs are untrusted. Only the application gateway may resolve AI credentials. Execution workers receive scoped capabilities, not vault access.

## 3. Functional requirements and verification
### AUTH — P0
- SRS-AUTH-001: The system shall create a personal workspace exactly once after verified registration.
- SRS-AUTH-002: The system shall reject expired or revoked sessions and authorize every resource request.
- SRS-AUTH-003: The system shall support email/password and Google/GitHub sign-in; recovery tokens are single-use and expire.

Verification TEST-AUTH-01: Attempt cross-tenant reads and replay revoked sessions; both fail.

### AIG — P0
- SRS-AIG-001: The system shall normalize provider requests and streaming events without exposing secrets.
- SRS-AIG-002: The system shall validate model capabilities before dispatch; support OpenAI, Anthropic, OpenRouter and compatible custom endpoints.
- SRS-AIG-003: The system shall normalize provider errors and usage; cancellation stops local processing and requests upstream cancellation where supported.

Verification TEST-AIG-01: Mock each adapter, malformed stream, timeout and cancellation.

### KEY — P0
- SRS-KEY-001: The system shall accept named multiple credentials per provider; encrypt before persistence.
- SRS-KEY-002: The system shall return only alias, status and masked identifier; test, disable, rotate and delete credentials.
- SRS-KEY-003: The system shall validate custom endpoint destinations against egress policy; block private addresses except through approved local bridge.

Verification TEST-KEY-01: Inspect responses/logs for secrets; disable key then attempt dispatch.

### MOD — P0
- SRS-MOD-001: The system shall discover models when supported and allow manual identifiers.
- SRS-MOD-002: The system shall store capabilities, context/output limits, pricing version and enabled state.
- SRS-MOD-003: The system shall reject incompatible parameters; P1 automatic routing must respect consent, budget and eligible models.

Verification TEST-MOD-01: Request unsupported tool capability and verify no provider dispatch.

### CHAT — P0
- SRS-CHAT-001: The system shall persist user message before dispatch and associate each response with model and run.
- SRS-CHAT-002: The system shall stream ordered deltas; support stop, edit/regenerate, rename, search, archive and delete.
- SRS-CHAT-003: The system shall switch model using authorized context; preserve partial output and terminal status.

Verification TEST-CHAT-01: Reconnect stream, regenerate and switch provider without losing authorized history.

### MMC — P0/P1/P2
- SRS-MMC-001: The system shall fan out identical authorized prompt to selected participants concurrently; isolate streams, failures and cancellation.
- SRS-MMC-002: The system shall support P0 basic group mode, mentions and authorized shared history; P1 bounded autonomous turns, roles, moderator and debate preserve disagreement and evidence.
- SRS-MMC-003: The system shall support P1 automatic routing that selects eligible models; P2 collaborative engineering uses approved task graph. Preserve MMC-001–020 in companion specification.

Verification TEST-MMC-01: Cancel one of two streams; other completes. Group reaches cap and stops.

### PROJ — P0
- SRS-PROJ-001: The system shall create, read, update and delete projects within workspace.
- SRS-PROJ-002: The system shall scope conversations and instructions to project; P0 basic project budgets; P1 files, tasks, repository and extended knowledge.
- SRS-PROJ-003: The system shall reject cross-project resource references without authorization.

Verification TEST-PROJ-01: Use distinct project instructions and verify isolation.

### CODE — P1
- SRS-CODE-001: The system shall index approved repository files; provide editor, terminal and diffs.
- SRS-CODE-002: The system shall apply proposed patch only to expected revision; reject stale patches.
- SRS-CODE-003: The system shall run commands and tests in isolated sandbox; checkpoint changes and support rollback.

Verification TEST-CODE-01: Reject stale patch, run test, revert checkpoint.

### BUILD — P1/P2
- SRS-BUILD-001: The system shall generate editable project scaffold and source from approved requirements.
- SRS-BUILD-002: The system shall build and preview in isolated runtime; report errors and export source.
- SRS-BUILD-003: The system shall p2 support Expo/React Native and Flutter builds subject to runtime availability.

Verification TEST-BUILD-01: Generate sample web app, build, preview and export.

### RES — P1
- SRS-RES-001: The system shall create bounded research plan, retrieve and timestamp sources.
- SRS-RES-002: The system shall associate factual claims with retrieved evidence; flag unsupported or conflicting claims.
- SRS-RES-003: The system shall export report and bibliography; stop at time/cost limits.

Verification TEST-RES-01: Reject invented citation; verify claim-to-source links.

### AGENT — P1/P2
- SRS-AGENT-001: The system shall persist agent configuration, steps, tool results and execution state.
- SRS-AGENT-002: The system shall enforce tool allowlists, time/step/cost caps and approval gates.
- SRS-AGENT-003: The system shall support pause/resume/cancel; P2 coordinate multiple agents with isolated task state.

Verification TEST-AGENT-01: Deny unauthorized tool, expire approval and resume safe checkpoint.

### MEM — P0/P1
- SRS-MEM-001: The system shall p0 apply project instructions; P1 index scoped documents and retrieve relevant chunks with provenance.
- SRS-MEM-002: The system shall support editing/deletion and retention; exclude unrelated workspace data.
- SRS-MEM-003: The system shall temporary sessions must not create persistent memory records.

Verification TEST-MEM-01: Delete document and verify retrieval exclusion.

### FILE — P1
- SRS-FILE-001: The system shall validate size, type and content before accepting upload.
- SRS-FILE-002: The system shall store ownership metadata and authorize download; isolate executable previews.
- SRS-FILE-003: The system shall version artifacts and export supported formats.

Verification TEST-FILE-01: Reject oversized or unauthorized upload/download.

### GIT — P1
- SRS-GIT-001: The system shall use scoped GitHub authorization to import repositories and inspect revisions.
- SRS-GIT-002: The system shall create branches, commits and PRs only within granted permissions and approval policy.
- SRS-GIT-003: The system shall respect protected branches and report CI results accurately.

Verification TEST-GIT-01: Attempt unauthorized push and verify denial.

### COST — P0
- SRS-COST-001: The system shall record every dispatched request and provider usage when available.
- SRS-COST-002: The system shall atomically reserve estimated maximum cost across applicable budgets before dispatch.
- SRS-COST-003: The system shall reconcile actual usage, retain uncertain charges for reconciliation and distinguish estimated from reported costs.

Verification TEST-COST-01: Race two requests against one remaining budget; only eligible reservation succeeds.

### PLUG — P1
- SRS-PLUG-001: The system shall register integrations and discover capabilities; encrypt OAuth tokens.
- SRS-PLUG-002: The system shall authorize every tool call by workspace and scope; audit result.
- SRS-PLUG-003: The system shall revoke connection and deny subsequent calls.

Verification TEST-PLUG-01: Revoke token then attempt tool invocation.

### DEPLOY — P2
- SRS-DEPLOY-001: The system shall generate deployment configuration (P1); connect approved deployment provider (P2).
- SRS-DEPLOY-002: The system shall require explicit approval for production release; bind approval to exact revision and target.
- SRS-DEPLOY-003: The system shall report build status, redact logs and support provider rollback where available.

Verification TEST-DEPLOY-01: Change revision after approval; deployment must require new approval.

### AUTO — P2
- SRS-AUTO-001: The system shall persist workflow definitions, triggers and execution history.
- SRS-AUTO-002: The system shall deduplicate trigger delivery and enforce step/time/budget limits.
- SRS-AUTO-003: The system shall retry only safe or idempotent steps; notify failures.

Verification TEST-AUTO-01: Replay webhook and verify single logical execution.

### LIB — P0/P1
- SRS-LIB-001: The system shall p0 save and retrieve scoped prompts.
- SRS-LIB-002: The system shall p1 validate template variables, categorize and import/export skills.
- SRS-LIB-003: The system shall p2 version and share templates with permission checks.

Verification TEST-LIB-01: Reject missing required template variable.

### TEAM — P2
- SRS-TEAM-001: The system shall create organizations and invite members with scoped roles.
- SRS-TEAM-002: The system shall enforce shared project and budget permissions.
- SRS-TEAM-003: The system shall record membership changes and revoke subsequent access immediately.

Verification TEST-TEAM-01: Remove member and verify subsequent access denied.

## 4. Business rules
- BR-01: Every resource operation requires authenticated ownership or workspace permission; deny by default.
- BR-02: Credential alias is not a secret; plaintext is write-only and resolved only for authorized provider calls.
- BR-03: Never silently switch provider or credential. Fallback requires configured authorization and fresh budget check.
- BR-04: Cross-provider transcript/file sharing requires explicit authorization; independent parallel responses do not see one another by default.
- BR-05: Budget checks are atomic. Unknown prices block dispatch unless user explicitly permits a bounded estimate. Local limits cannot guarantee external provider invoices.
- BR-06: Approval binds action, target, revision, scope and expiry; changed action requires new approval.
- BR-07: Model agreement is not evidence. Research claims require retrieved sources or uncertainty labels.
- BR-08: All external writes and production changes require applicable approval; no unrestricted agent autonomy.

## 5. State machines
Run: queued → validating → reserved → running → completed/failed/cancelled; validation may fail before reservation. Running may enter awaiting_approval or paused and return to running after authorization. Terminal states cannot restart; retry creates a new attempt linked to original run. Cancellation is best effort upstream; reconcile late usage. Persist transitions with timestamps and compare-and-set version.

Credential: unverified → active/invalid; active → disabled/invalid/revoked; disabled → active after validation; revoked terminal. Rotation creates new secret version; existing runs retain their authorized version until cancelled or completed.

Parallel conversation: parent run contains independent child runs; aggregate completed, partial, failed or cancelled from child terminal states. Group/debate: plan → participant turns → optional critique → synthesis → terminal; stop on caps, cancellation or policy failure. Synthesis itself consumes budget.

Budget reservation: pending → reserved → reconciled/released; uncertain upstream usage → reconciliation_required. Never release uncertain charge solely because client disconnected.

## 6. Core use cases
| Use case | Preconditions | Normal flow | Alternate flow |
|---|---|---|---|
| UC-01 Connect provider | Authenticated | Enter alias/key → encrypt → test → activate | Invalid key remains inactive; redact error |
| UC-02 Single chat | Active model/key | Validate → reserve → stream → persist → reconcile | Timeout/cancel preserves partial response |
| UC-03 Parallel chat | Two eligible participants | Reserve eligible child calls → concurrent streams → aggregate | One fails independently; show per-child status |
| UC-04 Group discussion | P1, consent and caps | Select participants → bounded turns → synthesis | Stop at cap, show partial transcript |
| UC-05 Research | P1, search configured | Plan → retrieve → verify → report | Missing evidence marked unresolved |
| UC-06 Code change | P1, approved repo | Inspect → propose diff → approve → sandbox tests | Stale revision or failed tests block approved release |

## 7. Data and validation
Use opaque IDs, UTC timestamps, explicit workspace ownership, immutable usage events and versioned pricing. Validate nonempty prompt, supported model ID, bounded output tokens, participant uniqueness and positive budgets. Store money as fixed precision decimal or integer micro-units, never binary floating point. Reject unknown fields in sensitive mutations. File quotas and context limits must be configurable. Deletion removes active records and derived retrieval data according to disclosed retention; backup expiry documented. Exact schema and numeric limits pending ERD/API decisions.

## 8. Interface and errors
Versioned /api/v1; authenticated JSON APIs and SSE for generation. Canonical gateway/API events: accepted, queued, started, text_delta, reasoning_summary, tool_call_delta, tool_call_ready, usage_update, warning, completed, failed, cancelled. Envelope follows docs/07-ai-gateway.md and OpenAPI; advanced events only when supported. Reconnect from last acknowledged sequence where retained; otherwise fetch persisted snapshot. Mutating requests use idempotency keys where duplicate effects are possible. Error envelope: code, safe message, trace_id, retryable. HTTP 400 invalid input, 401 unauthenticated, 403 forbidden, 404 unavailable resource, 409 conflict, 422 unsupported capability, 429 rate/budget limit, 502 upstream failure, 504 timeout. Never return raw upstream secrets. Retry bounded transient failures only; avoid duplicate billable requests when upstream outcome unknown.

## 9. Nonfunctional requirements
PRD targets: initial load <3s, internal API p95 <500ms excluding upstream, stream overhead p95 <300ms, typical search <2s, MVP availability 99.5%, daily backup, RPO 24h/RTO 4h, WCAG 2.2 AA. Proposed test baseline: 20 concurrent active sessions on documented staging hardware, report p95 and error rate; validate workload before adopting as release threshold. Browser support current stable Chrome, Firefox, Edge, Safari. Redacted structured logs, trace IDs, health checks and versioned migrations required.

## 10. Security verification
Test tenant isolation, session revocation, secret redaction, SSRF including redirects/DNS rebinding, XSS in rendered Markdown, CSRF where cookie authentication applies, upload validation, prompt injection tool boundaries, sandbox resource caps and approval replay. Use non-root disposable execution, restricted egress, no host mounts or default secrets. No critical unresolved security finding at release.

## 11. Traceability
- PRD AUTH → SRS-AUTH-001 through -003 → TEST-AUTH-01 (P0).
- PRD AIG → SRS-AIG-001 through -003 → TEST-AIG-01 (P0).
- PRD KEY → SRS-KEY-001 through -003 → TEST-KEY-01 (P0).
- PRD MOD → SRS-MOD-001 through -003 → TEST-MOD-01 (P0).
- PRD CHAT → SRS-CHAT-001 through -003 → TEST-CHAT-01 (P0).
- PRD MMC → SRS-MMC-001 through -003 → TEST-MMC-01 (P0/P1/P2).
- PRD PROJ → SRS-PROJ-001 through -003 → TEST-PROJ-01 (P0).
- PRD CODE → SRS-CODE-001 through -003 → TEST-CODE-01 (P1).
- PRD BUILD → SRS-BUILD-001 through -003 → TEST-BUILD-01 (P1/P2).
- PRD RES → SRS-RES-001 through -003 → TEST-RES-01 (P1).
- PRD AGENT → SRS-AGENT-001 through -003 → TEST-AGENT-01 (P1/P2).
- PRD MEM → SRS-MEM-001 through -003 → TEST-MEM-01 (P0/P1).
- PRD FILE → SRS-FILE-001 through -003 → TEST-FILE-01 (P1).
- PRD GIT → SRS-GIT-001 through -003 → TEST-GIT-01 (P1).
- PRD COST → SRS-COST-001 through -003 → TEST-COST-01 (P0).
- PRD PLUG → SRS-PLUG-001 through -003 → TEST-PLUG-01 (P1).
- PRD DEPLOY → SRS-DEPLOY-001 through -003 → TEST-DEPLOY-01 (P2).
- PRD AUTO → SRS-AUTO-001 through -003 → TEST-AUTO-01 (P2).
- PRD LIB → SRS-LIB-001 through -003 → TEST-LIB-01 (P0/P1).
- PRD TEAM → SRS-TEAM-001 through -003 → TEST-TEAM-01 (P2).
These test IDs are planned verification scenarios, not implemented tests. Full per-feature mapping and P3 detail remain pending.

## 12. Release gates
P0 onboarding, valid multi-key connection, single/parallel chat, independent cancellation, persistent history, projects, saved prompts, usage ledger, atomic budgets and tenant isolation must pass. All critical tests green, CI evidence recorded, no secrets exposed, rollback and recovery documented. HAC-001–011 and MVP shared context acceptance are also mandatory. Other P1/P2 capabilities are not required for MVP release.

## 13. Open decisions
Approval expiry, retention durations, exact quotas, provider pricing and credit restrictions, API schemas, sandbox technology, load profile and deployment infrastructure require ADRs and validation. No live provider calls or application tests performed.

## 14. Collaboration requirements and traceability
Normative [HAC-001–030 with individual acceptance scenarios](19-human-ai-collaboration.md) and [CTX-001–010](20-shared-intelligence.md). SRS-HAC-001: persist and sequence room events before broadcast; reconnect without duplicate effects. SRS-HAC-002: authorize membership, subscriptions and provider dispatch independently. SRS-HAC-003: identify AI actors and require explicit invocation or bounded configured triggers. SRS-HAC-004: scope shared credentials and reserve team budgets atomically. SRS-HAC-005: retrieve only authorized current context and preserve provenance. SRS-HAC-006: record actor and action in durable activity log. P0 tests: two human clients and two mocked models; invite/revoke, concurrent messages, reconnect, private context exclusion, shared key permission and budget race. Advanced collaboration remains phased. Tests planned, not executed.
