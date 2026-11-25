# Human–AI Collaboration Specification

Version 1.0 | 2026-11-25

## Purpose
Eliminate fragmented conversations, context loss, duplicate work and avoidable cost. Support human-human, human-AI, human-multiple AI, multiple humans-AI, multiple humans-multiple AI, AI-AI, human-agent and team-multi-agent collaboration. Easy, affordable, fast, lively, context-aware and controlled.

## Requirements and acceptance
| ID | Requirement | Priority | Planned acceptance |
|---|---|---|---|
| HAC-001 | Shared project workspaces | P0 | Two invited members access same project; outsider denied |
| HAC-002 | Invite human collaborators | P0 | Invite expires and cannot be replayed |
| HAC-003 | Shared human–AI conversations | P0 | Both humans see persisted messages and AI responses |
| HAC-004 | Multiple AI participants | P0 | Two AI participants respond with distinct identities |
| HAC-005 | Human and AI mentions | P0 | Mention triggers only intended authorized participant |
| HAC-006 | Shared project context | P0 | Both users retrieve same approved project facts |
| HAC-007 | Real-time messaging | P0 | Reconnect recovers ordered messages without duplicates |
| HAC-008 | Participant permissions | P0 | Revoked member loses subsequent access |
| HAC-009 | Shared and personal credential policies | P0 | Personal key remains private; shared key usable only by authorized roles |
| HAC-010 | Team usage and spending limits | P0 | Concurrent reservations cannot exceed configured local budget |
| HAC-011 | Project activity feed | P0 | Activity records actor, action and timestamp |
| HAC-012 | Presence indicators | P1 | Presence expires after disconnect |
| HAC-013 | Dedicated collaboration rooms | P1 | Room access follows membership |
| HAC-014 | Automatic context synchronization | P1 | New approved revision becomes retrievable; stale version flagged |
| HAC-015 | Shared decision register | P1 | Proposal cannot become approved without authorized action |
| HAC-016 | AI teammate onboarding | P1 | Onboarding summary links to current sources |
| HAC-017 | Human–AI task assignments | P1 | Assignment identifies human or agent and accountable owner |
| HAC-018 | Shared project board | P1 | Task transitions synchronize across clients |
| HAC-019 | Duplicate task detection | P1 | Duplicate candidate flagged for review |
| HAC-020 | AI-to-human handoffs | P1 | Handoff includes artifacts, status and unresolved issues |
| HAC-021 | Real-time code editing | P1 | Concurrent human edits converge |
| HAC-022 | Concurrent change conflict detection | P1 | Stale AI patch rejected or rebased with review |
| HAC-023 | Shared previews | P1 | Preview access scoped to project |
| HAC-024 | Collaborative research | P1 | Sources and claims shared with authorized participants |
| HAC-025 | AI stand-up reports | P1 | Report links to actual activity |
| HAC-026 | Voice collaboration | P2 | Voice requires participant consent |
| HAC-027 | Video and screen sharing | P2 | Screen sharing requires explicit start/stop |
| HAC-028 | AI meeting participants | P2 | AI attendee clearly identified and recording consent enforced |
| HAC-029 | Collaborative whiteboard | P2 | Concurrent board changes converge |
| HAC-030 | Virtual office | P3 | Presence and room navigation respect privacy |

## MVP behavior
One shared project conversation, invited members, persistent ordered messages, explicit AI mentions, multiple AI participants, shared approved context, role permissions, shared/personal credential policies, budgets and activity. AI replies only when invoked or explicitly configured; no uncontrolled loops. Basic group conversation is P0; autonomous debate and moderator synthesis remain P1. Private chats and credentials are not automatically shared.

## Roles and coordination
Owner manages membership and spending; editor contributes messages and tasks; viewer reads permitted content. AI identities are clearly labeled and receive scoped capabilities, never human membership privileges or plaintext keys. Assign work with owner, expected revision, status, artifacts and handoff. Agents use isolated branches or reviewed patches; human edits are not silently overwritten.

## Realtime contract
Persist before broadcast; sequence events per room, deduplicate by client message ID, reconnect with cursor or snapshot. Authorize subscriptions and recheck membership on dispatch. Presence is ephemeral; durable audit events are separate. Human-only messages do not incur model charges. P1 editing protocol selection pending ADR.

## Cost and consent
Default personal keys private. Shared credentials require owner opt-in, member scope, provider disclosure and budgets. Never reveal key material. Reserve costs before each model call, including synthesis; cap rounds, output and concurrent calls. Record payer alias and initiating actor. External invoices can differ. Voice/video/recording require explicit consent.

## Metrics
Measure time to onboard teammate, context repetition, duplicate tasks, message delivery latency, cost per completed task and collaboration retention. Establish baselines with pilot teams; no savings guarantee.
