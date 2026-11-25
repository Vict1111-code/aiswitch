# System architecture

Status: proposed baseline — 2026-11-25.

Proposed Next.js/React/TypeScript frontend, FastAPI modular monolith, PostgreSQL/Supabase, object storage, Redis workers, isolated execution sandboxes. Request flow: authenticate, authorize workspace, reserve budget, invoke adapter, stream, persist and reconcile. Separate untrusted execution from application and credential vault. Scale based on measurements.
