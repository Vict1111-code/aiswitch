# Requirements traceability matrix

Proposed mapping; all tests planned, none executed. Mixed means decompose by phase before implementation. RT IDs are planned test identifiers, not existing executable tests. Issue assignments are recommendations, not proof of coverage. Source criteria preserved where possible; MMC criteria are shorthand and need detailed assertions. CTX phase assignment is proposed: curated lifecycle P0, indexing/decision/cache-specific tests P1; tenant isolation always P0. SRS TEAM basic membership P0, advanced P2. PRD unnumbered clauses, NFRs, API-01–12 and DB tests require additional mapping; no exhaustive coverage claim.

| Requirement | Priority | Issue | Planned test | Criterion | Source |
|---|---|---|---|---|---|
| GW-001 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-001 | Register two keys for same provider; select each independently | 07-ai-gateway.md |
| GW-002 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-002 | Mask credentials; browser and logs never receive secret | 07-ai-gateway.md |
| GW-003 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-003 | Rotate/revoke key; new dispatch denied for revoked version | 07-ai-gateway.md |
| GW-004 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-004 | Discover models or manually register when unsupported | 07-ai-gateway.md |
| GW-005 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-005 | Reject unsupported modality/tool capability | 07-ai-gateway.md |
| GW-006 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-006 | Normalize native OpenAI and Anthropic mock streams | 07-ai-gateway.md |
| GW-007 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-007 | Compatible adapter handles OpenRouter/custom mock | 07-ai-gateway.md |
| GW-008 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-008 | Two child streams progress concurrently | 07-ai-gateway.md |
| GW-009 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-009 | Cancel one child without cancelling sibling | 07-ai-gateway.md |
| GW-010 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-GW-010 | Reconnect without duplicate durable messages | 07-ai-gateway.md |
| GW-011 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-011 | Shared group mention targets authorized AI only | 07-ai-gateway.md |
| GW-012 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-012 | Human-only message creates no paid call | 07-ai-gateway.md |
| GW-013 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-GW-013 | Private context excluded from shared dispatch | 07-ai-gateway.md |
| GW-014 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-GW-014 | Revoked membership/consent blocks queued dispatch | 07-ai-gateway.md |
| GW-015 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-GW-015 | Concurrent reservations respect local budget | 07-ai-gateway.md |
| GW-016 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-GW-016 | Usage settlement idempotent; unknown usage retained | 07-ai-gateway.md |
| GW-017 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-GW-017 | Unknown price handled explicitly | 07-ai-gateway.md |
| GW-018 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-018 | Shared key requires scoped grant and payer policy | 07-ai-gateway.md |
| GW-019 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-GW-019 | Custom endpoint SSRF and redirect tests | 07-ai-gateway.md |
| GW-020 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-020 | Ambiguous timeout does not blindly retry | 07-ai-gateway.md |
| GW-021 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-GW-021 | Provider error redacted and normalized | 07-ai-gateway.md |
| GW-022 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-GW-022 | Manual credit balance labeled estimate | 07-ai-gateway.md |
| GW-023 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-GW-023 | Automatic routing respects capability and budget | 07-ai-gateway.md |
| GW-024 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-GW-024 | Fallback requires explicit allowed destination/payer | 07-ai-gateway.md |
| GW-025 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-GW-025 | Debate stops at configured round/cost cap | 07-ai-gateway.md |
| GW-026 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-GW-026 | Local bridge pairing and revocation | 07-ai-gateway.md |
| GW-027 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-GW-027 | Context cache cannot cross tenant boundaries | 07-ai-gateway.md |
| GW-028 | P2 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-GW-028 | Agent tool calls require scoped approval | 07-ai-gateway.md |
| HAC-001 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-HAC-001 | Two invited members access same project; outsider denied | 19-human-ai-collaboration.md |
| HAC-002 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-HAC-002 | Invite expires and cannot be replayed | 19-human-ai-collaboration.md |
| HAC-003 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-HAC-003 | Both humans see persisted messages and AI responses | 19-human-ai-collaboration.md |
| HAC-004 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-HAC-004 | Two AI participants respond with distinct identities | 19-human-ai-collaboration.md |
| HAC-005 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-HAC-005 | Mention triggers only intended authorized participant | 19-human-ai-collaboration.md |
| HAC-006 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-HAC-006 | Both users retrieve same approved project facts | 19-human-ai-collaboration.md |
| HAC-007 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-HAC-007 | Reconnect recovers ordered messages without duplicates | 19-human-ai-collaboration.md |
| HAC-008 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-HAC-008 | Revoked member loses subsequent access | 19-human-ai-collaboration.md |
| HAC-009 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-HAC-009 | Personal key remains private; shared key usable only by authorized roles | 19-human-ai-collaboration.md |
| HAC-010 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-HAC-010 | Concurrent reservations cannot exceed configured local budget | 19-human-ai-collaboration.md |
| HAC-011 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-HAC-011 | Activity records actor, action and timestamp | 19-human-ai-collaboration.md |
| HAC-012 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-012 | Presence expires after disconnect | 19-human-ai-collaboration.md |
| HAC-013 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-013 | Room access follows membership | 19-human-ai-collaboration.md |
| HAC-014 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-014 | New approved revision becomes retrievable; stale version flagged | 19-human-ai-collaboration.md |
| HAC-015 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-015 | Proposal cannot become approved without authorized action | 19-human-ai-collaboration.md |
| HAC-016 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-016 | Onboarding summary links to current sources | 19-human-ai-collaboration.md |
| HAC-017 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-017 | Assignment identifies human or agent and accountable owner | 19-human-ai-collaboration.md |
| HAC-018 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-018 | Task transitions synchronize across clients | 19-human-ai-collaboration.md |
| HAC-019 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-019 | Duplicate candidate flagged for review | 19-human-ai-collaboration.md |
| HAC-020 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-020 | Handoff includes artifacts, status and unresolved issues | 19-human-ai-collaboration.md |
| HAC-021 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-HAC-021 | Concurrent human edits converge | 19-human-ai-collaboration.md |
| HAC-022 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-HAC-022 | Stale AI patch rejected or rebased with review | 19-human-ai-collaboration.md |
| HAC-023 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-HAC-023 | Preview access scoped to project | 19-human-ai-collaboration.md |
| HAC-024 | P1 | [#13](https://github.com/Vict1111-code/aiswitch/issues/13) | RT-HAC-024 | Sources and claims shared with authorized participants | 19-human-ai-collaboration.md |
| HAC-025 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-HAC-025 | Report links to actual activity | 19-human-ai-collaboration.md |
| HAC-026 | P2 | [#18](https://github.com/Vict1111-code/aiswitch/issues/18) | RT-HAC-026 | Voice requires participant consent | 19-human-ai-collaboration.md |
| HAC-027 | P2 | [#18](https://github.com/Vict1111-code/aiswitch/issues/18) | RT-HAC-027 | Screen sharing requires explicit start/stop | 19-human-ai-collaboration.md |
| HAC-028 | P2 | [#18](https://github.com/Vict1111-code/aiswitch/issues/18) | RT-HAC-028 | AI attendee clearly identified and recording consent enforced | 19-human-ai-collaboration.md |
| HAC-029 | P2 | [#18](https://github.com/Vict1111-code/aiswitch/issues/18) | RT-HAC-029 | Concurrent board changes converge | 19-human-ai-collaboration.md |
| HAC-030 | P3 | [#18](https://github.com/Vict1111-code/aiswitch/issues/18) | RT-HAC-030 | Presence and room navigation respect privacy | 19-human-ai-collaboration.md |
| MMC-001 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-001 | Verify single chat | 18-multi-model-chat.md |
| MMC-002 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-002 | Verify switch model | 18-multi-model-chat.md |
| MMC-003 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-003 | Verify parallel responses | 18-multi-model-chat.md |
| MMC-004 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-004 | Verify side-by-side comparison | 18-multi-model-chat.md |
| MMC-005 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-005 | Verify basic group conversation | 18-multi-model-chat.md |
| MMC-006 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-006 | Verify basic shared context | 18-multi-model-chat.md |
| MMC-007 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-007 | Verify @mentions | 18-multi-model-chat.md |
| MMC-008 | P1 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-008 | Verify dynamic participants | 18-multi-model-chat.md |
| MMC-009 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-MMC-009 | Verify bounded rounds | 18-multi-model-chat.md |
| MMC-010 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-MMC-010 | Verify critique/debate | 18-multi-model-chat.md |
| MMC-011 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-MMC-011 | Verify moderator/synthesis | 18-multi-model-chat.md |
| MMC-012 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-MMC-012 | Verify roles | 18-multi-model-chat.md |
| MMC-013 | P2 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-MMC-013 | Verify collaborative execution | 18-multi-model-chat.md |
| MMC-014 | P1 | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-MMC-014 | Verify automatic routing | 18-multi-model-chat.md |
| MMC-015 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-MMC-015 | Verify per-model costs | 18-multi-model-chat.md |
| MMC-016 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-MMC-016 | Verify conversation budget | 18-multi-model-chat.md |
| MMC-017 | P1 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-017 | Verify independent/shared context | 18-multi-model-chat.md |
| MMC-018 | P0 | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-MMC-018 | Verify individual cancellation | 18-multi-model-chat.md |
| MMC-019 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-MMC-019 | Verify branching | 18-multi-model-chat.md |
| MMC-020 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-MMC-020 | Verify templates | 18-multi-model-chat.md |
| CTX-001 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-CTX-001 | private record excluded from shared query | 20-shared-intelligence.md |
| CTX-002 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-CTX-002 | approved revision supersedes old context | 20-shared-intelligence.md |
| CTX-003 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-CTX-003 | revoked access blocks retrieval and dispatch | 20-shared-intelligence.md |
| CTX-004 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-CTX-004 | duplicate indexing event is idempotent | 20-shared-intelligence.md |
| CTX-005 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-CTX-005 | deleted source invalidates derived retrieval | 20-shared-intelligence.md |
| CTX-006 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-CTX-006 | context manifest identifies sources and token estimate | 20-shared-intelligence.md |
| CTX-007 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-CTX-007 | unapproved AI proposal cannot override decision | 20-shared-intelligence.md |
| CTX-008 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-CTX-008 | provider consent enforced | 20-shared-intelligence.md |
| CTX-009 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-CTX-009 | stale index flagged | 20-shared-intelligence.md |
| CTX-010 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-CTX-010 | cache cannot cross tenant boundaries | 20-shared-intelligence.md |
| SM-01 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-01 | queued cancellation: cancelled; pending reservation released | 25-state-machines.md |
| SM-02 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-02 | pre-dispatch authorization revoked: failed; release only if no dispatch proven | 25-state-machines.md |
| SM-03 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-03 | worker crash after dispatch intent: no blind retry; reconciliation_required | 25-state-machines.md |
| SM-04 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-04 | one child cancelled: siblings unaffected | 25-state-machines.md |
| SM-05 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-05 | late provider usage after cancellation: settle without changing execution terminal | 25-state-machines.md |
| SM-06 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-06 | duplicate usage event: no second ledger mutation | 25-state-machines.md |
| SM-07 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-07 | concurrent budget reservations: all scopes locked; reject excess | 25-state-machines.md |
| SM-08 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-08 | actual exceeds estimate: record actual; block future excess | 25-state-machines.md |
| SM-09 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-09 | completion races cancellation: first committed terminal wins; late usage still accepted | 25-state-machines.md |
| SM-10 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-10 | expired worker lease: fencing token rejects stale worker writes | 25-state-machines.md |
| SM-11 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-11 | unknown price: reject capped paid dispatch | 25-state-machines.md |
| SM-12 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-12 | same idempotency key different hash: 409; no dispatch | 25-state-machines.md |
| SM-13 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-13 | all children terminal mixed outcomes: parent partial if any completed, otherwise failed if any failed, else cancelled | 25-state-machines.md |
| SM-14 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-14 | reconciliation without evidence: retain reservation | 25-state-machines.md |
| SM-15 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SM-15 | late correction after settlement: append compensating ledger entry; no duplicate canonical cost | 25-state-machines.md |
| SM-16 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SM-16 | replayed terminal event: one durable terminal, transport dedup | 25-state-machines.md |
| SRS-AUTH-001 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-AUTH-001 | The system shall create a personal workspace exactly once after verified registration. | 03-srs.md |
| SRS-AUTH-002 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-AUTH-002 | The system shall reject expired or revoked sessions and authorize every resource request. | 03-srs.md |
| SRS-AUTH-003 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-AUTH-003 | The system shall support email/password and Google/GitHub sign-in; recovery tokens are single-use and expire. | 03-srs.md |
| SRS-AIG-001 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SRS-AIG-001 | The system shall normalize provider requests and streaming events without exposing secrets. | 03-srs.md |
| SRS-AIG-002 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SRS-AIG-002 | The system shall validate model capabilities before dispatch; support OpenAI, Anthropic, OpenRouter and compatible custom endpoints. | 03-srs.md |
| SRS-AIG-003 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SRS-AIG-003 | The system shall normalize provider errors and usage; cancellation stops local processing and requests upstream cancellation where supported. | 03-srs.md |
| SRS-KEY-001 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-SRS-KEY-001 | The system shall accept named multiple credentials per provider; encrypt before persistence. | 03-srs.md |
| SRS-KEY-002 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-SRS-KEY-002 | The system shall return only alias, status and masked identifier; test, disable, rotate and delete credentials. | 03-srs.md |
| SRS-KEY-003 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-SRS-KEY-003 | The system shall validate custom endpoint destinations against egress policy; block private addresses except through approved local bridge. | 03-srs.md |
| SRS-MOD-001 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-SRS-MOD-001 | The system shall discover models when supported and allow manual identifiers. | 03-srs.md |
| SRS-MOD-002 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-SRS-MOD-002 | The system shall store capabilities, context/output limits, pricing version and enabled state. | 03-srs.md |
| SRS-MOD-003 | P0 | [#5](https://github.com/Vict1111-code/aiswitch/issues/5) | RT-SRS-MOD-003 | The system shall reject incompatible parameters; P1 automatic routing must respect consent, budget and eligible models. | 03-srs.md |
| SRS-CHAT-001 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-CHAT-001 | The system shall persist user message before dispatch and associate each response with model and run. | 03-srs.md |
| SRS-CHAT-002 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-CHAT-002 | The system shall stream ordered deltas; support stop, edit/regenerate, rename, search, archive and delete. | 03-srs.md |
| SRS-CHAT-003 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-CHAT-003 | The system shall switch model using authorized context; preserve partial output and terminal status. | 03-srs.md |
| SRS-MMC-001 | mixed | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-SRS-MMC-001 | The system shall fan out identical authorized prompt to selected participants concurrently; isolate streams, failures and cancellation. | 03-srs.md |
| SRS-MMC-002 | mixed | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-SRS-MMC-002 | The system shall support P0 basic group mode, mentions and authorized shared history; P1 bounded autonomous turns, roles, moderator and debate preserve disagreement and evidence. | 03-srs.md |
| SRS-MMC-003 | mixed | [#10](https://github.com/Vict1111-code/aiswitch/issues/10) | RT-SRS-MMC-003 | The system shall support P1 automatic routing that selects eligible models; P2 collaborative engineering uses approved task graph. Preserve MMC-001–020 in companion specification. | 03-srs.md |
| SRS-PROJ-001 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-PROJ-001 | The system shall create, read, update and delete projects within workspace. | 03-srs.md |
| SRS-PROJ-002 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-PROJ-002 | The system shall scope conversations and instructions to project; P0 basic project budgets; P1 files, tasks, repository and extended knowledge. | 03-srs.md |
| SRS-PROJ-003 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-PROJ-003 | The system shall reject cross-project resource references without authorization. | 03-srs.md |
| SRS-CODE-001 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-SRS-CODE-001 | The system shall index approved repository files; provide editor, terminal and diffs. | 03-srs.md |
| SRS-CODE-002 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-SRS-CODE-002 | The system shall apply proposed patch only to expected revision; reject stale patches. | 03-srs.md |
| SRS-CODE-003 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-SRS-CODE-003 | The system shall run commands and tests in isolated sandbox; checkpoint changes and support rollback. | 03-srs.md |
| SRS-BUILD-001 | mixed | [#15](https://github.com/Vict1111-code/aiswitch/issues/15) | RT-SRS-BUILD-001 | The system shall generate editable project scaffold and source from approved requirements. | 03-srs.md |
| SRS-BUILD-002 | mixed | [#15](https://github.com/Vict1111-code/aiswitch/issues/15) | RT-SRS-BUILD-002 | The system shall build and preview in isolated runtime; report errors and export source. | 03-srs.md |
| SRS-BUILD-003 | mixed | [#15](https://github.com/Vict1111-code/aiswitch/issues/15) | RT-SRS-BUILD-003 | The system shall p2 support Expo/React Native and Flutter builds subject to runtime availability. | 03-srs.md |
| SRS-RES-001 | P1 | [#13](https://github.com/Vict1111-code/aiswitch/issues/13) | RT-SRS-RES-001 | The system shall create bounded research plan, retrieve and timestamp sources. | 03-srs.md |
| SRS-RES-002 | P1 | [#13](https://github.com/Vict1111-code/aiswitch/issues/13) | RT-SRS-RES-002 | The system shall associate factual claims with retrieved evidence; flag unsupported or conflicting claims. | 03-srs.md |
| SRS-RES-003 | P1 | [#13](https://github.com/Vict1111-code/aiswitch/issues/13) | RT-SRS-RES-003 | The system shall export report and bibliography; stop at time/cost limits. | 03-srs.md |
| SRS-AGENT-001 | mixed | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-SRS-AGENT-001 | The system shall persist agent configuration, steps, tool results and execution state. | 03-srs.md |
| SRS-AGENT-002 | mixed | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-SRS-AGENT-002 | The system shall enforce tool allowlists, time/step/cost caps and approval gates. | 03-srs.md |
| SRS-AGENT-003 | mixed | [#16](https://github.com/Vict1111-code/aiswitch/issues/16) | RT-SRS-AGENT-003 | The system shall support pause/resume/cancel; P2 coordinate multiple agents with isolated task state. | 03-srs.md |
| SRS-MEM-001 | mixed | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-SRS-MEM-001 | The system shall p0 apply project instructions; P1 index scoped documents and retrieve relevant chunks with provenance. | 03-srs.md |
| SRS-MEM-002 | mixed | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-SRS-MEM-002 | The system shall support editing/deletion and retention; exclude unrelated workspace data. | 03-srs.md |
| SRS-MEM-003 | mixed | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-SRS-MEM-003 | The system shall temporary sessions must not create persistent memory records. | 03-srs.md |
| SRS-FILE-001 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-SRS-FILE-001 | The system shall validate size, type and content before accepting upload. | 03-srs.md |
| SRS-FILE-002 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-SRS-FILE-002 | The system shall store ownership metadata and authorize download; isolate executable previews. | 03-srs.md |
| SRS-FILE-003 | P1 | [#12](https://github.com/Vict1111-code/aiswitch/issues/12) | RT-SRS-FILE-003 | The system shall version artifacts and export supported formats. | 03-srs.md |
| SRS-GIT-001 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-SRS-GIT-001 | The system shall use scoped GitHub authorization to import repositories and inspect revisions. | 03-srs.md |
| SRS-GIT-002 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-SRS-GIT-002 | The system shall create branches, commits and PRs only within granted permissions and approval policy. | 03-srs.md |
| SRS-GIT-003 | P1 | [#14](https://github.com/Vict1111-code/aiswitch/issues/14) | RT-SRS-GIT-003 | The system shall respect protected branches and report CI results accurately. | 03-srs.md |
| SRS-COST-001 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SRS-COST-001 | The system shall record every dispatched request and provider usage when available. | 03-srs.md |
| SRS-COST-002 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SRS-COST-002 | The system shall atomically reserve estimated maximum cost across applicable budgets before dispatch. | 03-srs.md |
| SRS-COST-003 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SRS-COST-003 | The system shall reconcile actual usage, retain uncertain charges for reconciliation and distinguish estimated from reported costs. | 03-srs.md |
| SRS-PLUG-001 | P1 | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-PLUG-001 | The system shall register integrations and discover capabilities; encrypt OAuth tokens. | 03-srs.md |
| SRS-PLUG-002 | P1 | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-PLUG-002 | The system shall authorize every tool call by workspace and scope; audit result. | 03-srs.md |
| SRS-PLUG-003 | P1 | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-PLUG-003 | The system shall revoke connection and deny subsequent calls. | 03-srs.md |
| SRS-DEPLOY-001 | mixed | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-DEPLOY-001 | The system shall generate deployment configuration (P1); connect approved deployment provider (P2). | 03-srs.md |
| SRS-DEPLOY-002 | mixed | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-DEPLOY-002 | The system shall require explicit approval for production release; bind approval to exact revision and target. | 03-srs.md |
| SRS-DEPLOY-003 | mixed | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-DEPLOY-003 | The system shall report build status, redact logs and support provider rollback where available. | 03-srs.md |
| SRS-AUTO-001 | P2 | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-AUTO-001 | The system shall persist workflow definitions, triggers and execution history. | 03-srs.md |
| SRS-AUTO-002 | P2 | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-AUTO-002 | The system shall deduplicate trigger delivery and enforce step/time/budget limits. | 03-srs.md |
| SRS-AUTO-003 | P2 | [#17](https://github.com/Vict1111-code/aiswitch/issues/17) | RT-SRS-AUTO-003 | The system shall retry only safe or idempotent steps; notify failures. | 03-srs.md |
| SRS-LIB-001 | mixed | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-LIB-001 | The system shall p0 save and retrieve scoped prompts. | 03-srs.md |
| SRS-LIB-002 | mixed | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-LIB-002 | The system shall p1 validate template variables, categorize and import/export skills. | 03-srs.md |
| SRS-LIB-003 | mixed | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-LIB-003 | The system shall p2 version and share templates with permission checks. | 03-srs.md |
| SRS-TEAM-001 | mixed | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-TEAM-001 | The system shall create organizations and invite members with scoped roles. | 03-srs.md |
| SRS-TEAM-002 | mixed | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-TEAM-002 | The system shall enforce shared project and budget permissions. | 03-srs.md |
| SRS-TEAM-003 | mixed | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-TEAM-003 | The system shall record membership changes and revoke subsequent access immediately. | 03-srs.md |
| SRS-HAC-001 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-HAC-001 | persist and sequence room events before broadcast; reconnect without duplicate effects | 03-srs.md |
| SRS-HAC-002 | P0 | [#4](https://github.com/Vict1111-code/aiswitch/issues/4) | RT-SRS-HAC-002 | authorize membership, subscriptions and provider dispatch independently | 03-srs.md |
| SRS-HAC-003 | P0 | [#9](https://github.com/Vict1111-code/aiswitch/issues/9) | RT-SRS-HAC-003 | identify AI actors and require explicit invocation or bounded configured triggers | 03-srs.md |
| SRS-HAC-004 | P0 | [#6](https://github.com/Vict1111-code/aiswitch/issues/6) | RT-SRS-HAC-004 | scope shared credentials and reserve team budgets atomically | 03-srs.md |
| SRS-HAC-005 | P0 | [#8](https://github.com/Vict1111-code/aiswitch/issues/8) | RT-SRS-HAC-005 | retrieve only authorized current context and preserve provenance | 03-srs.md |
| SRS-HAC-006 | P0 | [#7](https://github.com/Vict1111-code/aiswitch/issues/7) | RT-SRS-HAC-006 | record actor and action in durable activity log | 03-srs.md |
