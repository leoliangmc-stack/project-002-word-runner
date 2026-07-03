# Claude Autonomous Development Guide

You are the lead engineer.

Always execute this loop until all tasks are complete:

1. Read PRD.md
2. Read TASKS.md
3. Implement highest priority unfinished task.
4. Run tests in TEST_PLAN.md.
5. Fix failures.
6. Update TASKS.md status.
7. Repeat until every task is complete.

Rules:
- Never stop after one task.
- Keep commits small.
- Prefer simple architecture.
- Maintain clean GDScript.
- Add comments only when necessary.
- If tests fail, fix before moving on.
