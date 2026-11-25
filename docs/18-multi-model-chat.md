# Multi-model chat specification

Status: proposed baseline — 2026-11-25.

MMC-001 single chat P0; MMC-002 switch model P0; MMC-003 parallel responses P0; MMC-004 side-by-side comparison P0; MMC-005 basic group conversation P0; MMC-006 basic shared context P0; MMC-007 @mentions P0; MMC-008 dynamic participants P1; MMC-009 bounded rounds P1; MMC-010 critique/debate P1; MMC-011 moderator/synthesis P1; MMC-012 roles P1; MMC-013 collaborative execution P2; MMC-014 automatic routing P1; MMC-015 per-model costs P0; MMC-016 conversation budget P0; MMC-017 independent/shared context P1; MMC-018 individual cancellation P0; MMC-019 branching P1; MMC-020 templates P1.

Parallel: fan out identical prompt to selected models, stream independently, isolate failures. Group: orchestrator passes authorized transcript to participants in bounded turns; mentions target specific participants. Debate: independent answers then critiques and evidence-grounded synthesis; disagreement preserved. Collaborative: role-based task graph with approvals. Auto: capability/cost/policy routing. Require explicit cross-provider data sharing, per-run reservation, max rounds, cancellation and no hidden fallback. Acceptance: two models stream concurrently; one can fail or cancel without stopping the other; group stops at cap; moderator is an enabled participant; every billable call recorded.

## Human collaboration alignment
P0 basic group conversation supports multiple humans and AI participants, shared authorized context and mentions. Advanced autonomous rounds, debate and moderator remain P1. Every response has actor/model identity and independent status. Human-only messages do not trigger AI by default. See [HAC](19-human-ai-collaboration.md) and [context](20-shared-intelligence.md).
