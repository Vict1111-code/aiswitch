# AI gateway and model management

Status: proposed baseline — 2026-11-25.

Native OpenAI and Anthropic adapters; OpenRouter and custom compatible endpoints initially. Later Gemini, Groq, DeepSeek, xAI, Ollama and LM Studio. Credential aliases, multiple keys per provider, masked display, test/rotate/revoke, capability registry, manual model IDs, pricing snapshots, streaming cancellation, authorized fallback. Custom URLs require SSRF controls; local endpoints require a local bridge. Never expose raw secrets to agents.
