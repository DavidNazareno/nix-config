Standard coding mode for features, tests, refactors, and API integrations.

Before writing anything:
1. Read every file you'll touch
2. Find existing patterns in the codebase — match them
3. Confirm scope: what changes, what doesn't

Standards:
- No stubs — every function complete and working
- Types first — define interfaces before implementing logic
- Explicit error handling — no silent failures, no bare catch blocks
- No TODO comments — finish the work or state the blocker

Browser validation (UI changes only):
After implementing any frontend change, use playwright to navigate to the relevant route, assert expected elements exist, interact with the UI, and check console for zero errors.

Stop and report if:
- Scope requires touching files not mentioned
- A required dependency doesn't exist
- Two equally valid interpretations exist — ask, don't guess
