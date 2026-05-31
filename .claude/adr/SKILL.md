---
name: adr
category: learning
description: Creates an Architecture Decision Record (ADR) capturing a non-trivial design decision — what was decided, what alternatives were considered, the trade-offs, and which system design concepts apply. Produces a permanent, searchable record in docs/decisions/<component>/. Triggers on "/adr", "why did we choose", "document this decision", "record this trade-off", or when a significant design choice is made during implementation.
---

# Architecture Decision Record (ADR)

An ADR captures the *why* behind a design decision at the moment it is clearest — before the context fades. The goal is not documentation for its own sake, but a future reference you can actually use: when you revisit this code in 3 months, the ADR explains what you were trading off, not just what you chose.

Format based on Michael Nygard's ADR template, extended with system design concept references.

---

## Step 1 — Gather Context

Ask the user (in one message, wait for full answer):

```
To write the ADR, I need:
1. What did you decide? (one sentence — the actual choice made)
2. What problem were you solving or constraint were you working within?
3. What alternatives did you consider? (even if briefly — list them)
4. What are the main consequences of this choice — what gets easier, what gets harder?
```

If the context is already clear from the recent diff or conversation, pre-fill your best understanding and ask: "Does this capture the decision correctly, or do you want to adjust anything?"

Do not proceed until the user confirms or provides the information.

---

## Step 2 — Identify the Component and Slug

- **Component:** which service, module, or package this decision belongs to (e.g. `auth-service`, `payments-api`, or `shared` for cross-cutting decisions)
- **Slug:** 3–5 word kebab-case title (e.g. `jwt-over-session-cookies`, `postgres-over-mongodb`, `async-queue-for-emails`)
- **Sequence number:** check `docs/decisions/<component>/` for existing ADRs. The new file gets the next number: `0001-`, `0002-`, etc. If directory is empty, start at `0001-`.

File path: `docs/decisions/<component>/<NNNN>-<slug>.md`

---

## Step 3 — Map to System Design Concepts

From the decision, identify 1–3 relevant system design concepts or engineering principles. Be specific — name the precise concept, not the broad category:

- Not just "distributed systems" — specify "at-least-once vs exactly-once delivery"
- Not just "consistency" — specify "read-your-writes consistency"
- Not just "storage" — specify "log-structured vs B-tree storage trade-offs"

Cite the source when one applies (DDIA chapter, RFC, named pattern, or paper). These become revision anchors — when you revisit this decision or encounter the concept in a quiz, you'll have a real trade-off to ground it in.

---

## Step 4 — Write the ADR

Create the file at the path from Step 2:

```markdown
# <NNNN>. <Title — human-readable version of the slug>

**Date:** <YYYY-MM-DD>  
**Status:** Accepted  
**Component:** <component-name>  
**Decided by:** <user / pair / team>

---

## Context

<2–4 sentences. What situation or constraint prompted this decision?
What would have happened without an explicit choice here?>

---

## Decision

<1–3 sentences. The actual choice made, stated plainly.>

---

## Alternatives Considered

| Option | Why rejected |
|---|---|
| <Alternative 1> | <One-line reason it wasn't chosen> |
| <Alternative 2> | <One-line reason it wasn't chosen> |
| *(add more rows as needed)* | |

---

## Consequences

**Gets easier:**
- <What this decision makes simpler or cheaper>

**Gets harder / trade-offs accepted:**
- <What this decision makes more complex, slower, or riskier>

**Constraints this introduces:**
- <Any hard constraints future work must respect as a result of this decision>

---

## System Design Concepts

| Concept | Reference / Source | How it applies here |
|---|---|---|
| <concept> | <book Ch N / RFC / pattern name> | <one sentence> |
| <concept> | <book Ch N / RFC / pattern name> | <one sentence> |

---

## Related

- ADR(s) this supersedes or is related to: <links or "none">
- Constraints propagated: <yes/no — if this decision introduces hard constraints, note where they were recorded (architecture doc, constraints file, etc.)>
```

---

## Step 5 — Update the Index

Append a row to `docs/decisions/README.md`:

```markdown
| <NNNN> | [<Title>](<component>/<NNNN>-<slug>.md) | <component> | <YYYY-MM-DD> | Accepted |
```

If `docs/decisions/README.md` doesn't exist, create it:

```markdown
# Architecture Decision Records

> Permanent record of non-trivial design decisions made during this project.
> Each ADR captures: decision, alternatives, trade-offs, and relevant system design concepts.

| # | Title | Component | Date | Status |
|---|---|---|---|---|
```

---

## Step 6 — Optionally Propagate Constraints

If the decision introduces a hard constraint that future work must respect (e.g. "never call this external API synchronously in the request path"), record it where your project tracks architectural rules. This could be:

- A `## Do Not` or `## Constraints` section in a component's context/architecture doc
- A `CLAUDE.md` rule in the affected directory
- A comment in a relevant config or interface file

Example constraint entry:
```
- Do not call <external-service> synchronously — use the async queue (see ADR 0001)
```

Ask: "Should I add this constraint to your project's architecture doc or a relevant file?" — if yes, make the edit.

---

## Step 7 — Confirm and Summarise

```
ADR created: docs/decisions/<component>/<NNNN>-<slug>.md
Index updated: docs/decisions/README.md
Constraints propagated: <yes / no — and where>

Concepts anchored:
  - <concept> → <reference>
  - <concept> → <reference>
```

---

## References

- Nygard, Michael. "Documenting Architecture Decisions." Cognitect Blog, 2011. https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions — source of the ADR format used here.
- ADR GitHub organization — catalog of ADR templates and tooling: https://adr.github.io/
