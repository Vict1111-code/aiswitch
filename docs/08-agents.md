# Agent architecture

Status: proposed baseline — 2026-11-25.

Planner, architect, coder, tester, reviewer, researcher, security and documentation roles. State machine: queued → planning → running → awaiting approval → completed/failed/canceled. Persist steps and tool results. L0 advisory, L1 read-only, L2 propose, L3 sandbox execution, L4 bounded workflows. Enforce time, step, token and spending caps; approve external writes and production changes.
