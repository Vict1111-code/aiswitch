# Security and privacy

Status: proposed baseline — 2026-11-25.

Threats: credential theft, tenant leakage, SSRF, prompt injection, sandbox escape, runaway costs and supply chain compromise. Controls: TLS, envelope encryption, scoped authorization, redaction, egress restrictions, audit logs, quotas and dependency scanning. Untrusted code runs non-root in isolated disposable environments without host mounts or default secrets. Explicit approval for pushes, merges and production operations. Disclose external provider data sharing.
