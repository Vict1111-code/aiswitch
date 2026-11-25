# AISwitch — API contracts
Version 1.0 | 2026-11-25 | Proposed baseline

## 1. Scope
Machine-readable [OpenAPI 3.1 contract](openapi.yaml) covers 35 initial P0 operations. JSON syntax is used as a YAML 1.2-compatible representation. This is a subset, not a complete PRD implementation. Authentication via Supabase Auth SDK; backend validates JWT issuer, audience, expiry and membership. No deployed API.

## 2. Conventions
Base /api/v1. HTTPS, JSON, opaque UUIDs, UTC ISO timestamps, decimal strings for money. Reject unknown fields on sensitive writes. Cursor pagination stable and tenant scoped; default 50 maximum 100. Return trace ID in error and response header. No raw provider secrets. Credential secret is write-only on input, never echoed. Scope all resources to authorized workspace; path IDs are not authorization. Use 404 for inaccessible resource where disclosure would leak existence.

## 3. Routes
| Method | Path | Operation | Priority |
|---|---|---|---|
| GET | /workspaces | listWorkspaces | P0 |
| POST | /workspaces | createWorkspace | P0 |
| GET | /workspaces/{workspace_id}/projects | listProjects | P0 |
| POST | /workspaces/{workspace_id}/projects | createProject | P0 |
| GET | /workspaces/{workspace_id}/rooms | listRooms | P0 |
| POST | /workspaces/{workspace_id}/rooms | createRoom | P0 |
| POST | /workspaces/{workspace_id}/invites | createInvite | P0 |
| POST | /invites/{invite_id}/accept | acceptInvite | P0 |
| DELETE | /workspaces/{workspace_id}/members/{user_id} | revokeMember | P0 |
| GET | /providers | listProviders | P0 |
| GET | /workspaces/{workspace_id}/credentials | listCredentials | P0 |
| POST | /workspaces/{workspace_id}/credentials | createCredential | P0 |
| POST | /workspaces/{workspace_id}/credentials/{credential_id}/test | testCredential | P0 |
| POST | /workspaces/{workspace_id}/credentials/{credential_id}/rotate | rotateCredential | P0 |
| DELETE | /workspaces/{workspace_id}/credentials/{credential_id} | revokeCredential | P0 |
| POST | /workspaces/{workspace_id}/credentials/{credential_id}/grants | grantCredential | P0 |
| POST | /workspaces/{workspace_id}/credentials/{credential_id}/credits | recordCredit | P0 |
| GET | /workspaces/{workspace_id}/models | listModels | P0 |
| POST | /workspaces/{workspace_id}/models/sync | syncModels | P0 |
| GET | /workspaces/{workspace_id}/rooms/{room_id}/messages | listMessages | P0 |
| POST | /workspaces/{workspace_id}/rooms/{room_id}/messages | createMessage | P0 |
| POST | /workspaces/{workspace_id}/rooms/{room_id}/participants | addParticipant | P0 |
| GET | /workspaces/{workspace_id}/rooms/{room_id}/events | listRoomEvents | P0 |
| POST | /workspaces/{workspace_id}/rooms/{room_id}/runs | createRun | P0 |
| GET | /workspaces/{workspace_id}/runs/{run_id} | getRun | P0 |
| POST | /workspaces/{workspace_id}/runs/{run_id}/cancel | cancelRun | P0 |
| POST | /workspaces/{workspace_id}/runs/{run_id}/children/{child_id}/cancel | cancelChild | P0 |
| GET | /workspaces/{workspace_id}/budgets | listBudgets | P0 |
| POST | /workspaces/{workspace_id}/budgets | createBudget | P0 |
| GET | /workspaces/{workspace_id}/usage | listUsage | P0 |
| GET | /workspaces/{workspace_id}/activity | listActivity | P0 |
| POST | /workspaces/{workspace_id}/projects/{project_id}/context | createContext | P0 |
| POST | /workspaces/{workspace_id}/consents | createConsent | P0 |
| DELETE | /workspaces/{workspace_id}/consents/{consent_id} | revokeConsent | P0 |
| GET | /workspaces/{workspace_id}/runs/{run_id}/stream | streamRun | P0 |

## 4. Mutations and concurrency
POST requires Idempotency-Key scoped to actor/workspace/operation; store request hash and result, same key with different payload returns 409. Replay never creates second paid run. DELETE revocation idempotent. Proposed retention 24h minimum, durable paid-run dedup longer; ADR pending. Future updates use revision/If-Match and 409 stale revision. Human messages persisted before explicit run creation; mentions alone do not create duplicate dispatch. Validate participant belongs to room, credential grant, provider consent and budget before dispatch. Shared room creation and project binding require explicit project_id in final typed schema; current generic NamedInput is provisional.

## 5. Errors
400 malformed; 401 invalid JWT; 403 denied; 404 unavailable; 409 conflict; 422 unsupported/validation; 429 rate or budget limit (distinguish code); 502 upstream failure; 504 timeout. Envelope code/message/trace_id/retryable. Retry-After where appropriate. Use gateway taxonomy; ambiguous upstream outcome not retryable by default. Errors after SSE headers are typed failed events.

## 6. SSE
GET run stream with bearer authorization using fetch streaming (native EventSource cannot set arbitrary authorization header). Last-Event-ID resumes retained events; if expired fetch run/message snapshot. Event id, event type and JSON data; normalized Event schema in OpenAPI. Per-child sequence, independent cancellation, heartbeat comments, terminal durable state; at-least-once delivery. Shared room events separately distributed with ACL; private run never broadcast. Financial reconciliation remains separate from run status.

## 7. WebSocket protocol
Proposed /api/v1/realtime. TLS; obtain short-lived single-use connection ticket through authenticated endpoint (contract pending), never put long-lived JWT in URL. Client frames subscribe(room_id,after_seq), unsubscribe(room_id), ping. Server frames subscribed, room_event(event_id,room_id,seq,kind,payload), snapshot_required, access_revoked, error, pong. Persist before broadcast; dedup by event_id; replay authorized durable history. Recheck membership on subscribe, delivery and revocation; close on expired authorization. Bounded buffers and heartbeat; reconnect with backoff. No client writes via socket in P0. OpenAPI does not model WebSocket protocol; AsyncAPI later.

## 8. Example flow
Create workspace/project → invite teammate → create shared room → register AI participants → post human message → explicitly create run with selected participants and consent → reserve child costs → stream independently → reconcile usage. A human-only message never creates a paid call by default. Cancel child without cancelling siblings.

## 9. Planned contract tests
API-01 JWT rejection; API-02 cross-tenant IDs; API-03 credential response redaction; API-04 idempotency replay/conflict; API-05 cursor isolation; API-06 concurrent budget reservation; API-07 two model streams; API-08 independent cancel; API-09 reconnect and dedup; API-10 revoked subscription; API-11 private context exclusion; API-12 error redaction. Mock providers in CI. No runtime tests executed.

## 10. Remaining contract coverage
Typed resource-specific list schemas, project/room create fields, invite token proof, credential rotation-specific input, custom endpoints/manual models, grant revocation, message edit/regenerate/archive/search, project update/delete, prompts, context revision/delete, consent scope details, budget updates, reconciliation status, ticket endpoint, typed event payloads and P1/P2 files/research/agents/Git/deployment/workflows remain pending. Generic Page/Resource/Ack are placeholders. Resolve before implementation of affected routes. Validate with OpenAPI linter and generated clients in CI; current generation only checks unique operation IDs and schema references. No external validator executed.

## 11. P0 contract expansion (v1.1)
OpenAPI now contains 54 operations and 62 schemas; its machine-readable routes supersede the initial table above. Typed resource pages replace generic pages in list responses. Room creation requires project_id; invitation acceptance requires write-only token bound to verified recipient, expiry and one-time consumption; rotation accepts secret only. Credential tests require explicit billable permission. Ticket endpoint POST /workspaces/{workspace_id}/realtime/tickets issues a single-use short-lived secret (proposed 60 seconds), bound to actor/workspace; no logging or long-lived JWT in URL. Custom endpoints require HTTPS, SSRF/redirect checks and credential endpoint binding. Manual models are endpoint-scoped. Added grant revocation, project rename/archive, room archive, message edit/regenerate/search, participant removal, prompts, context revision/revoke, budget update and child status. Edits require expected revision; preserve history and invalidate derived context. Regeneration creates new explicit run and reservation; path and body message IDs must match. Child financial status independent of execution. Budget changes cannot erase committed usage. Remaining: precise consent scope, typed SSE payload union, ticket replay behavior, list pagination for added routes, complete response typing and independent lint/client generation. No runtime implementation or tests. Static unique operation IDs and schema refs checked only.
