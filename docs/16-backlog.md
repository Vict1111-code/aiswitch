# Engineering backlog v1.0

17 proposed work packages; issue IDs below reflect successful creation only. Dependencies refer to stable backlog IDs. All open, no implementation evidence.

| ID | Priority | Work package | Dependencies | Traceability | Acceptance | GitHub |
|---|---|---|---|---|---|---|
| F01 | P0 | Review architecture and close specification gaps | none | ADR-001–017; API section 10 | Record accepted/deferred ADRs; reconcile P0 scope, typed contracts and schema; lint OpenAPI | [#2](https://github.com/Vict1111-code/aiswitch/issues/2) |
| F02 | P0 | Scaffold monorepo and CI | F01 | ADR-003,016 | Local web/API/worker boot; lint/typecheck/test/secret scan pass; no paid CI calls | [#3](https://github.com/Vict1111-code/aiswitch/issues/3) |
| F03 | P0 | Identity, workspace and tenant isolation | F02 | HAC-001,002,008 | Two invited users access project; expired invite and outsider denied; RLS tests | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) |
| F04 | P0 | Credential vault and model registry | F03 | GW-001–005,018,019,022 | Two keys per provider; rotate/revoke; discovery/manual model; SSRF and redaction tests | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) |
| F05 | P0 | Budget reservations and usage ledger | F03,F04 | GW-015–017; HAC-010 | Concurrent reservations obey local cap; idempotent settlement; unknown usage retained | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) |
| F06 | P0 | Shared rooms and durable realtime | F03 | HAC-003,005,007,011 | Ordered messages, reconnect, revoke, no duplicate events; human-only no AI charge | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) |
| F07 | P0 | Curated shared context and consent | F03,F06 | HAC-006; CTX-001–010; GW-013,014 | Versioned facts and manifests; private exclusion and revocation tests | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) |
| F08 | P0 | Provider adapters and durable streaming | F04,F05,F07 | GW-006–010,020,021 | Mock OpenAI/Anthropic/compatible streams; crash recovery; independent cancel | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) |
| F09 | P0 | Collaborative multi-model chat UI | F06,F08 | HAC-004,005,009; MMC-001–005,015,016,018 | Two humans and two models share room; explicit invocation, payer and usage visible | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) |
| F10 | P0 | MVP security, pilot and release gate | F09 | SRS NFR; API-01–12 | E2E, isolation, restore, accessibility and cost tests; capped opt-in live smoke; review pilot | [#11](https://github.com/Vict1111-code/aiswitch/issues/11) |
| F11 | P1 | Project intelligence and task coordination | F10 | HAC-012–020,025; CTX | Presence, decisions, retrieval, task handoffs and freshness tests | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) |
| F12 | P1 | Research workspace | F10,F11 | HAC-024; SRS-RES | Evidence-linked report; unsupported claims flagged; SSRF tests | [#13](https://github.com/Vict1111-code/aiswitch/issues/13) |
| F13 | P1 | Code studio, Git and sandbox | F10,F11 | HAC-021–023; SRS-CODE/GIT | Reviewed patches, stale revision rejection, isolated preview, convergence tests | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) |
| F14 | P1 | Web app builder | F13 | SRS-BUILD | Generate, preview, test and export sample app with approval | [#15](https://github.com/Vict1111-code/aiswitch/issues/15) |
| F15 | P1/P2 | Routing, debate and bounded agents | F08,F11,F13 | GW-023–028; SRS-AGENT | Consent-aware routing, bounded rounds, approval replay and pause/resume | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) |
| F16 | P2 | Integrations and mobile/desktop expansion | F14,F15 | SRS-PLUG/DEPLOY/AUTO | Scoped integration, deployment approval and client compatibility | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) |
| F17 | P2/P3 | Commercial and advanced collaboration | F10,F16 | HAC-026–030; SRS-TEAM | Pilot demand, consent, billing and privacy gates before rollout | [#18](https://github.com/Vict1111-code/aiswitch/issues/18) |

## Coverage clarifications
F06 includes P0 conversation CRUD/search/edit/regenerate and saved prompts (CHAT/LIB); F04 includes custom endpoint and manual model registration; F05 includes manual credit records and expiry; F07 includes P0 curated context revision/deletion; F08 includes GW-011–012 explicit invocation and isolated child outcomes. F11 includes P1 files/artifacts and context indexing. F01 must resolve detailed contracts and traceability before affected implementation. These are backlog clarifications, not completed tasks.
