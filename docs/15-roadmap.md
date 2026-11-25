# Implementation roadmap v1.0

Proposed 50-week indicative sequence; not a delivery commitment. Weeks are relative to implementation start after documentation review. No staffing or velocity validated.

| Phase | Weeks | Backlog | Exit gate |
|---|---|---|---|
| Foundation | 1–2 | F01–F03 | Accepted ADRs, typed contracts, CI, tenant isolation |
| Collaborative MVP | 3–8 | F04–F10 | Two humans/two models, durable room, context consent, budget and security pilot |
| Shared intelligence | 9–12 | F11 | Versioned knowledge, decisions and task handoffs |
| Research | 13–16 | F12 | Evidence and citation evaluation |
| Code studio | 17–22 | F13 | Reviewed Git changes and isolated execution |
| App builder | 23–28 | F14 | Tested web app export |
| Agents and routing | 29–34 | F15 | Bounded execution and approvals |
| Expansion | 35–42 | F16 | Scoped integrations and client tests |
| Commercial/advanced | 43–50+ | F17 | Demand, privacy and billing validation |

## Workflow
Issue → dependency review → feature branch → implementation plan → tests → PR → review → merge → close issue with evidence. No direct master changes. Require security checks for sensitive features. Do not use live paid providers in default CI. Re-estimate after F02 and pilot. Split epics into small vertical slices; no individual effort estimates until capacity known. P0 basic group chat and team budgets; P1 advanced debate; P2 meetings; P3 virtual office contingent on demand.
