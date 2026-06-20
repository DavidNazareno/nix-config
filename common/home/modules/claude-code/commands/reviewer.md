Code review mode. Review the code just written or the specified files.

Check for:
- Logic errors and edge cases not handled
- Missing error handling
- Security issues (injection, auth bypass, data leaks)
- Performance concerns (N+1 queries, unnecessary re-renders, blocking calls)
- Inconsistency with existing codebase patterns
- Missing or incorrect types

Output format:
- CRITICAL: must fix before merging
- WARNING: should fix, explain why
- SUGGESTION: optional improvement

Be specific — reference file and line. Don't flag style preferences unless they break consistency with the codebase.
