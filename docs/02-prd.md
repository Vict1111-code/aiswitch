# AISwitch — Product Requirements Document

Version 1.3 | 2026-11-25 | Proposed baseline

## 1. Executive summary
AISwitch is a provider-independent AI-native engineering workspace combining chat, coding, web/mobile app generation, research, knowledge and controlled agents. BYOK is foundational: multiple credentials per provider and extensible adapters, not a promise of universal protocol compatibility.

## 2. Vision and mission
Unify AI models and engineering workflows while preserving user control, affordability, portability and evidence quality.

## 3. Problem statement
Provider lock-in, fragmented tooling, lost context, unreliable code and research, unused credits and runaway spending motivate the product.

## 4. Objectives
Secure multi-provider access; concurrent model collaboration; portable software; evidence-based research; persistent scoped memory; bounded agents; transparent cost; extensible integrations.

## 5. Personas
Developers, AI engineers, vibe coders, students, researchers, founders, freelancers, teams and enterprises. Initial personas: individual developers and small teams with existing API credentials.

## 6. Scope
Web-first personal and small-team workspace; desktop/mobile clients and advanced commercial collaboration later. Generated mobile apps are distinct from the Studio mobile client.

## 7. Priorities
P0 MVP; P1 core engineering; P2 advanced; P3 future. Priority labels do not imply implemented status.

## 8. Functional requirements
### 8.1 Authentication and accounts (AUTH)
Priority: P0.

**Requirements:** Email/password, Google and GitHub login; verification, recovery, sessions, profile, personal workspace. P1 MFA, session revocation, export/deletion. P0 basic project membership and permissions; P2 advanced organizations and RBAC; P3 SSO.

**Acceptance:** Two users cannot read each other's resources; revoked sessions fail.

### 8.2 Universal AI gateway (AIG)
Priority: P0.

**Requirements:** Native OpenAI and Anthropic adapters, OpenRouter and custom compatible endpoints. Normalize requests, streaming, errors, usage, cancellation, discovery and manual registration. P1 tools, structured outputs, vision, retries, routing, embeddings, Gemini, DeepSeek, Groq, xAI, Mistral and local bridges. P2 Azure, Bedrock, Hugging Face and adapter SDK.

**Acceptance:** Contract tests cover each supported adapter; unsupported capabilities are rejected before billing.

### 8.3 Credential management (KEY)
Priority: P0.

**Requirements:** Add named credentials in settings, multiple keys per provider, validate, encrypt, mask, enable, disable, rotate, delete, select defaults and track usage. Custom endpoints specify protocol, auth, headers, model IDs, limits and prices. P0 scoped shared credentials and credential budgets; P1 authorized fallback; P2 temporary credentials.

**Acceptance:** No raw secret in logs, prompts, exports or client responses; revoked key cannot start new requests.

### 8.4 Model registry and routing (MOD)
Priority: P0.

**Requirements:** Discovery/manual model IDs, capability metadata, enable/disable, default, context and output limits, temperature. P0 manual parallel comparison; P1 reasoning controls, task recommendations, routing policies, health and fallback. P2 evaluation. Modes manual, economy, fast, performance, research, coding, automatic and custom.

**Acceptance:** Routing respects capabilities, consent and budget; chosen provider/model/credential alias is visible.

### 8.5 Chat workspace (CHAT)
Priority: P0.

**Requirements:** Create, stream, persist, search, rename, archive, delete, edit/regenerate, cancel, switch models, Markdown/code rendering, copy and system instructions, per-message usage. P1 attachments, branching, exports, temporary chats, math/diagrams and artifacts. P2 voice and sharing.

**Acceptance:** Switch model without losing authorized context; interrupted stream retains partial output with status.

### 8.6 Multi-model interaction (MMC)
Priority: P0/P1/P2.

**Requirements:** P0 single model, switching, concurrent independent parallel responses, side-by-side comparison, per-model usage, conversation budgets and independent cancellation. P0 basic shared group conversation, shared context and mentions; P1 dynamic participants, advanced bounded debate, moderator, roles, automatic routing, branches and templates. P2 collaborative engineering. See [all 20 MMC requirements](18-multi-model-chat.md).

**Acceptance:** Two streams run concurrently; one failure does not stop the other. Group stops at configured round/cost limit; synthesis preserves disagreements. Cross-provider sharing requires authorization.

### 8.7 Projects and workspaces (PROJ)
Priority: P0.

**Requirements:** CRUD, isolated conversations, descriptions and instructions. P0 basic membership, activity and budgets; P1 files, repositories, model config, knowledge, documentation, tasks and export/import. P2 templates, duplication and advanced organizations.

**Acceptance:** Project instructions apply only to selected project; access checked for each resource.

### 8.8 Code Studio (CODE)
Priority: P1.

**Requirements:** Explorer, tabs, syntax highlighting, search, code generation/explanation/refactoring, multi-file edits, diffs, accept/reject, terminal, sandbox, tests, dependencies, checkpoints, repository indexing and preview. P2 completion, language servers, debugging, local filesystem and dev containers; P1 collaborative editing. Initial JS/TS/Python/Go/HTML/CSS/SQL/Shell; expand Rust, Java, C/C++, C#, Dart, Kotlin, Swift, PHP.

**Acceptance:** Proposed patch is reviewable, tests run in isolation, rejected patch leaves original intact.

### 8.9 Application builder (BUILD)
Priority: P1.

**Requirements:** Prompt → requirements → architecture → design → implementation → preview → test → deploy → maintenance. P1 static sites, React/Vue/Next.js, SaaS, PWA, Go/FastAPI/Node APIs, AI apps; editable scaffolds, frontend/backend/schema, responsive previews, auth, Supabase/Firebase, export, Git, rollback, security review. P2 visual editing, screenshot-to-code, Expo/React Native, Flutter, desktop, mobile builds, deployment and templates. P3 native Kotlin/Swift.

**Acceptance:** Generated source is portable; preview is isolated; build/test failures are reported rather than concealed.

### 8.10 Deep Research (RES)
Priority: P1.

**Requirements:** Quick, deep, academic, technical, comparison, repository, market, document, learning and custom modes. Search, fetch, plan, store evidence, inline citations, bibliography, source quality, cross-checks, PDF analysis, reports, history, library, conflicts, uncertainty, progress, Markdown/PDF/DOCX export, time/cost caps, domain policies and claim traceability. P2 scholarly discovery, monitoring and reproducibility.

**Acceptance:** Citations resolve to retrieved evidence; unsupported claims marked; search is separate from model access.

### 8.11 Agent Studio (AGENT)
Priority: P1.

**Requirements:** Built-in roles: product/project manager, architect, designer, frontend/backend/mobile/database/AI engineer, researcher, tester, reviewer, security, DevOps, documentation, tutor, debugger. Model/instructions/tools per agent, decomposition, logs, approvals, budgets, pause/resume/cancel, durable state, reports, AGENT.md ingestion. P2 custom agents, parallel collaboration, evaluations, templates and schedules; P3 marketplace. L0 advisory through L4 bounded autonomous workflows.

**Acceptance:** Agents cannot access raw credentials; external writes and production changes require approval; stop at limits.

### 8.12 Memory and knowledge (MEM)
Priority: P1.

**Requirements:** P0 project instructions and curated shared context. P1 summaries, semantic retrieval, indexing, edit/delete, relevance ranking, provenance, context optimization, retention and temporary sessions. P2 versioning, graph, organizational knowledge and conflict detection. Scopes personal, project, conversation, organization and working memory.

**Acceptance:** Deletion removes associated retrieval records subject to disclosed retention; unrelated context is excluded.

### 8.13 Files and artifacts (FILE)
Priority: P1.

**Requirements:** Upload, organize, extract, search, code/text/Markdown/HTML/React/Mermaid preview, PDF/DOCX generation, ZIP import/export, versions, quotas and malicious file detection. P2 spreadsheet/slides and sharing.

**Acceptance:** Uploads validated; generated files downloadable; executable previews isolated.

### 8.14 Git integration (GIT)
Priority: P1.

**Requirements:** GitHub connect/discover/import, branch, commit, diff, PR, issue, review, CI, rollback, instructions and protected branches. P2 GitLab/Gitea, conflicts and releases. Workflow requirement → issue → branch → plan → implementation → tests → review → PR → approval → merge.

**Acceptance:** No unauthorized push or merge; protected branches respected.

### 8.15 Usage and budgets (COST)
Priority: P0.

**Requirements:** Track tokens, estimated request cost, provider/key/model, daily/monthly limits, alerts, dashboard, manual balances and pricing. P0 project/team/room limits and preflight reservation; P1 workflow limits, export, provider balance where available, caching and context optimization; manual credit expiry records P0. P2 billing reconciliation. Atomic reservations and actual usage reconciliation; distinguish estimated, reported and manually entered values.

**Acceptance:** Concurrent requests cannot bypass local reservations; unknown pricing requires explicit policy; external billing may differ.

### 8.16 Integrations (PLUG)
Priority: P1.

**Requirements:** Registry, connect/disconnect, OAuth vault, discovery, MCP client, per-tool permissions, audit and health. GitHub, Supabase, Firebase, Figma, Vercel, Docker, cloud, communication, research and automation integrations phased. P2 custom REST tools, SDK and versioning; P3 marketplace.

**Acceptance:** Revoked integration cannot execute; tool calls are scoped and audited.

### 8.17 Deployment (DEPLOY)
Priority: P2.

**Requirements:** P1 generate config. P2 provider connections, builds, secret references, preview, production approval, logs, rollback, history, domains, containers, mobile pipelines and health.

**Acceptance:** Production release requires explicit approval; logs redact secrets.

### 8.18 Workflows (AUTO)
Priority: P2.

**Requirements:** Reusable manual/scheduled/webhook/repository-triggered workflows, conditions, sequential/parallel tasks, history, notifications, retries and budget caps. P3 visual editor.

**Acceptance:** Duplicate trigger handling is idempotent; failures and costs are recorded.

### 8.19 Prompt and skill library (LIB)
Priority: P0/P1.

**Requirements:** P0 save prompts. P1 tags, variables, system templates, reusable skills, import/export. P2 workflow templates, versioning and shared libraries; P3 marketplace.

**Acceptance:** Saved prompt is reusable and variables are validated.

### 8.20 Organizations (TEAM)
Priority: P2.

**Requirements:** Organizations, invites, owner/admin/member/viewer, shared projects/chat/knowledge, budgets, model policies and audit logs. P0 basic realtime collaboration and membership; P3 enterprise governance.

**Acceptance:** Role changes take effect on subsequent requests; tenant boundaries remain enforced.

## 9. UX
Navigation: Home, Chat, Projects, Code Studio, App Builder, Research, Agents, Workflows, Knowledge, Integrations, Usage, Settings. Onboarding connects first provider and sends first prompt. Chat has model selector and parallel panels; group mode has participant mentions. IDE has explorer/editor/terminal/diff/assistant; research has source panel. Dark/light, responsive, keyboard-accessible, loading/error/empty states. Settings include credentials, models, routing, memory, security, budgets, integrations and shortcuts.

## 10. Technology and architecture
Proposed Next.js/React/TypeScript, Tailwind, Monaco, xterm.js, FastAPI, PostgreSQL/Supabase, pgvector, Redis workers, SSE, isolated sandboxes, GitHub Actions, OpenTelemetry, Expo and Tauri later. Modular monolith plus separate execution workers. Decisions require ADR approval.

## 11. Data
See [database design](05-database.md). Tenant ownership, scoped foreign keys, RLS where applicable, encrypted credential vault, versioned migrations and deletion of derived records.

## 12. API
Versioned /api/v1, authenticated authorization, typed validation, standardized errors, pagination, idempotency and streaming events. See [API](06-api.md); initial OpenAPI available; completeness and independent validation pending.

## 13. Nonfunctional requirements
Proposed targets: initial load under 3s under defined conditions; internal API p95 under 500ms excluding upstream; streaming overhead p95 under 300ms; typical search under 2s; async long jobs; 99.5% MVP availability, 99.9% mature; daily backups, RPO 24h/RTO 4h; WCAG 2.2 AA; current stable Chrome/Firefox/Edge/Safari. Establish test conditions before release.

## 14. Security/privacy
TLS, encryption, least privilege, tenant isolation, RLS, secure sessions, XSS/CSRF/injection protection, rate limits, dependency/secret scanning, non-root isolated execution, resource limits, restricted egress, prompt injection defenses, audit, deletion/export, backups, rotation, incident response, upload validation, SSRF controls and provider data-sharing disclosures. No raw keys to agents. Approve pushes, merges, production DB changes and deployments. See [security](11-security.md).

## 15. User stories
- US-001: As an authorized user, I need authentication and accounts to work within my workspace. Acceptance: Two users cannot read each other's resources; revoked sessions fail.
- US-002: As an authorized user, I need universal ai gateway to work within my workspace. Acceptance: Contract tests cover each supported adapter; unsupported capabilities are rejected before billing.
- US-003: As an authorized user, I need credential management to work within my workspace. Acceptance: No raw secret in logs, prompts, exports or client responses; revoked key cannot start new requests.
- US-004: As an authorized user, I need model registry and routing to work within my workspace. Acceptance: Routing respects capabilities, consent and budget; chosen provider/model/credential alias is visible.
- US-005: As an authorized user, I need chat workspace to work within my workspace. Acceptance: Switch model without losing authorized context; interrupted stream retains partial output with status.
- US-006: As an authorized user, I need multi-model interaction to work within my workspace. Acceptance: Two streams run concurrently; one failure does not stop the other. Group stops at configured round/cost limit; synthesis preserves disagreements. Cross-provider sharing requires authorization.
- US-007: As an authorized user, I need projects and workspaces to work within my workspace. Acceptance: Project instructions apply only to selected project; access checked for each resource.
- US-008: As an authorized user, I need code studio to work within my workspace. Acceptance: Proposed patch is reviewable, tests run in isolation, rejected patch leaves original intact.
- US-009: As an authorized user, I need application builder to work within my workspace. Acceptance: Generated source is portable; preview is isolated; build/test failures are reported rather than concealed.
- US-010: As an authorized user, I need deep research to work within my workspace. Acceptance: Citations resolve to retrieved evidence; unsupported claims marked; search is separate from model access.
- US-011: As an authorized user, I need agent studio to work within my workspace. Acceptance: Agents cannot access raw credentials; external writes and production changes require approval; stop at limits.
- US-012: As an authorized user, I need memory and knowledge to work within my workspace. Acceptance: Deletion removes associated retrieval records subject to disclosed retention; unrelated context is excluded.
- US-013: As an authorized user, I need files and artifacts to work within my workspace. Acceptance: Uploads validated; generated files downloadable; executable previews isolated.
- US-014: As an authorized user, I need git integration to work within my workspace. Acceptance: No unauthorized push or merge; protected branches respected.
- US-015: As an authorized user, I need usage and budgets to work within my workspace. Acceptance: Concurrent requests cannot bypass local reservations; unknown pricing requires explicit policy; external billing may differ.
- US-016: As an authorized user, I need integrations to work within my workspace. Acceptance: Revoked integration cannot execute; tool calls are scoped and audited.
- US-017: As an authorized user, I need deployment to work within my workspace. Acceptance: Production release requires explicit approval; logs redact secrets.
- US-018: As an authorized user, I need workflows to work within my workspace. Acceptance: Duplicate trigger handling is idempotent; failures and costs are recorded.
- US-019: As an authorized user, I need prompt and skill library to work within my workspace. Acceptance: Saved prompt is reusable and variables are validated.
- US-020: As an authorized user, I need organizations to work within my workspace. Acceptance: Role changes take effect on subsequent requests; tenant boundaries remain enforced.

## 16. Business
BYOK free tier; proposed Pro $15/month, Team $25/user/month, enterprise custom. Provider charges separate; search/sandbox/storage may require quotas. Validate demand and margins before pricing commitments.

## 17. Metrics
Targets: valid provider connection >=95%; chat success >=98% excluding upstream outages/invalid credentials; billable request recording 100%; onboarding under 5 minutes; zero secret exposure/tenant leakage; citation validity >=95%, unsupported claims <5% on defined evaluation set; coding acceptance >=70%; critical tests and tested budget scenarios 100%; beta 25–50; paid conversion 5% hypothesis.

## 18. Roadmap
Weeks 1–2 foundation; 3–8 collaborative multi-model MVP; 9–12 projects/memory; 13–16 research; 17–22 code/Git; 23–28 app builder; 29–34 agents; 35–42 integrations/mobile/desktop; 43–50+ commercial. Indicative only, supersedes earlier 24-week plan.

## 19. MVP release gate
Auth, encrypted multi-key vault, OpenAI/Anthropic/OpenRouter/custom compatible adapters, model discovery/manual registration, streaming single and parallel chat, history, projects/instructions, prompt saving, cancellation, per-model costs, budgets, settings and CI. Also requires HAC-001–011: invitations, shared human–AI chat, mentions, realtime messaging, shared context, roles, credential policies, team budgets and activity. Excludes full IDE, autonomous agents, native clients, marketplace, deployment automation and enterprise. Release only after end-to-end onboarding, independent stream failure/cancellation, tenant isolation and concurrent budget tests pass.

## 20. QA
Unit, contract, integration, E2E, security, accessibility, performance, sandbox, recovery and versioned AI evaluations. No critical defects; actual tests rather than model approval alone.

## 21. Risks
Credential theft, tenant leakage, sandbox escape, credit exhaustion, provider changes, fabricated citations, prompt injection, uncontrolled execution, infrastructure cost, licensing and scope creep. See [risk register](17-risks.md).

## 22. Definition of done
Acceptance criteria met, tests pass, security and accessibility checked, errors handled, docs/migrations updated, CI green, reviewed PR, no unresolved critical defects.

## 23. Constraints
Provider access, promotional credit restrictions/expiry, differing model capabilities, separate search services, local hardware, sandbox costs, mobile build infrastructure, external account permissions and uncertain commercial demand. No current pricing or credit balance verified.

## 24. Future opportunities
Marketplace, local-first desktop, self-hosted enterprise, collaboration, visual design, computer-use agents, multimodal generation and private knowledge systems.

## 25. Product statement
One extensible workspace for provider-independent AI chat, engineering, research and controlled collaboration, with user ownership of code and credentials.

## 26. Supporting documents and decisions
See [index](README.md). Stack, modular monolith, 50-week roadmap, pricing, quality targets and Expo are proposed, not approved. SRS, logical ERD, initial OpenAPI and proposed ADRs exist; detailed per-feature traceability and physical implementation remain pending. This is an expanded structured adaptation of the conversational PRD, not a verbatim reproduction.

## 27. Human–AI collaboration (HAC)
Collaboration is foundational. [HAC-001–030](19-human-ai-collaboration.md) and [shared intelligence](20-shared-intelligence.md) are normative companion requirements. P0 basic group chat, invitations, shared project context, realtime messages, permissioned credentials, team budgets and activity. P1 presence, rooms, decisions, task coordination, collaborative editing/research. P2 voice/video/whiteboard; P3 virtual office. Basic membership is P0; advanced organization administration remains P2. Seven proposed engines: gateway, collaboration, shared intelligence, engineering, orchestration, research and resource optimization. Track context repetition and cost per completed task. This section supersedes conflicting personal-only scope or team priority statements.
