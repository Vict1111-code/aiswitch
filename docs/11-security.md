# Security and privacy

Status: proposed baseline — 2026-11-25.

Threats: credential theft, tenant leakage, SSRF, prompt injection, sandbox escape, runaway costs and supply chain compromise. Controls: TLS, envelope encryption, scoped authorization, redaction, egress restrictions, audit logs, quotas and dependency scanning. Untrusted code runs non-root in isolated disposable environments without host mounts or default secrets. Explicit approval for pushes, merges and production operations. Disclose external provider data sharing.

## Collaboration trust boundaries
Project membership and per-resource ACLs govern read/write/subscription. Recheck authorization on provider dispatch and reconnect; revoke active subscriptions on membership removal. Personal credentials private by default; shared credentials opt-in with scoped usage and payer budgets. AI identities cannot grant access. Context indexes and caches tenant-scoped; provider sharing consent and provenance required. Approval binds actor, action, revision and target. Recording and screen sharing require explicit consent. Test revocation, cross-tenant retrieval, concurrent budget races and replay.
