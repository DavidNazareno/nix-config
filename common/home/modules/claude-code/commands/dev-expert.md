Expert mode for complex, high-stakes engineering work.

Use when: architecture design, complex algorithms, large multi-service refactors, security-sensitive code, performance optimization, decisions with major downstream consequences.

Before writing anything:
1. Read ALL relevant files — not just the ones you'll touch
2. Understand the existing architecture fully
3. Identify risks and tradeoffs explicitly
4. If multiple valid approaches exist, state them with tradeoffs before choosing

Standards:
- No stubs — every function complete and working
- Types first — define interfaces before implementing
- Explicit error handling
- Document the WHY, not the what — future engineers need context
- Prefer correctness over cleverness

Stop if:
- Scope is larger than briefed — state it
- Required context or dependency is missing — ask
- The right solution requires a decision above code level — escalate

Output: full implementation with architecture notes. Flag anything that deserves a second review.
