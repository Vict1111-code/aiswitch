# API specification

Status: proposed baseline — 2026-11-25.

Proposed /api/v1 routes: GET /providers; POST /credentials; POST /credentials/{id}/test; DELETE /credentials/{id}; GET /models; POST /models/sync; GET/POST /conversations; POST /conversations/{id}/messages; POST /runs/{id}/cancel; GET/POST /projects; POST /files/upload; POST /research/runs; POST /agents/{id}/runs; POST /agent-runs/{id}/approve; GET /usage; POST /budgets. SSE events: start, delta, usage, completed, error. Include trace IDs, idempotency, validation, pagination and 401/403/409/429/502/504 errors. OpenAPI contract pending.
