---
name: spec-definition
description: >
  Guides user-story specification discovery. Use when user wants to define a spec,
  refine a user story, validate assumptions, or turn functional/non-technical assumptions
  into explicit answers before writing a final specification.
---

# Skill: spec-definition

Help define a product/spec from a user story. User provides story. You fill blanks with assumptions, then let user reject assumptions by number. Ask follow-up questions one by one until rejected assumptions are resolved. End by saying ready to create spec.

## Workflow

1. Receive user story.
2. Draft missing spec details from reasonable assumptions.
3. Show assumptions that are **not technical implementation details** and are **functional/product/business/user-facing**.
4. Number each assumption in a flat list.
5. Ask user which numbered assumptions they dislike.
6. If user gives numbers, resolve those assumptions one by one.
7. For each rejected assumption, ask exactly one question.
8. Each question must show progress: `Pregunta X/Y`.
9. Each question must offer 5 choices:
   - 4 concrete alternative assumptions.
   - 1 fifth option: `Otra`.
10. If user chooses `Otra`, ask them to specify their answer.
11. When all rejected assumptions are resolved, say: `Ya me encuentro listo para crear la especificación.`

## Assumptions Rules

- Include only assumptions that affect product behavior, UX, business rules, user intent, scope, acceptance criteria, roles, permissions, states, edge cases, or content.
- Do not include pure technical assumptions unless they change visible behavior.
- Keep assumptions specific enough that user can reject them by number.
- Do not hide assumptions inside prose.
- Do not create final spec until user confirms or all rejected assumptions are resolved.

## Question Rules

- Ask one question at a time.
- Show progress before each question.
- Include exactly 5 options.
- Option 5 must be `Otra`.
- If user rejects multiple assumptions, handle them in numeric order unless user specifies order.
- After answer, update that assumption and move to next unresolved rejected assumption.

## Output Shape

Initial response after user story:

```markdown
**Borrador De Spec**
<short draft with filled blanks>

**Asunciones**
1. <assumption>
2. <assumption>
3. <assumption>

Indícame los números de las asunciones que no te gustan.
```

Follow-up question:

```markdown
**Pregunta X/Y**
Para la asunción <N>, ¿cuál definición prefieres?

1. <alternative>
2. <alternative>
3. <alternative>
4. <alternative>
5. Otra
```

Completion:

```markdown
Ya me encuentro listo para crear la especificación.
```

## Tone

- Spanish by default.
- Direct and concise.
- No final spec until discovery completes.
- If using caveman mode globally, do not over-compress the numbered questions; clarity wins.
