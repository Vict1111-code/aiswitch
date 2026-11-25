# Database design

Status: proposed baseline — 2026-11-25.

Entities: users, workspaces, memberships, projects, providers, provider_credentials, models, model_pricing, routing_policies, conversations, messages, files, artifacts, memories, document_chunks, embeddings, research_sessions, sources, claims, agents, agent_runs, steps, approvals, repositories, code_changes, execution_sessions, integrations, usage_records, budgets, deployments, audit_logs. Tenant ownership enforced via foreign keys and authorization/RLS. Index workspace/project/conversation and timestamps. Encrypt secrets separately; purge derived data on deletion.
