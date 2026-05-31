# Claude Instructions — ai-skills Repo

This repo distributes Claude Code skills as standalone markdown files. Each skill is one file: `.claude/<skill-name>/SKILL.md`.

---

## 1. Repo Structure

```
/
├── .claude/
│   ├── <skill-name>/
│   │   └── SKILL.md        ← the skill (one file per skill)
├── install.sh              ← installer script
├── README.md
└── CLAUDE.md               ← this file
```

Each skill directory contains exactly one file: `SKILL.md`. No subdirectories, no assets.

---

## 2. Before Starting Any Task

- Read `README.md` to understand what skills exist and what state the repo is in
- Check git log for recent changes: `git log --oneline -10`
- Never modify an existing skill's intent or trigger behavior without an explicit instruction to do so

---

## 3. Skill File Schema

Every `SKILL.md` must have this frontmatter:

```yaml
---
name: skill-name           # kebab-case, matches directory name
category: <learning | tooling | workflow | review>
description: One sentence. What the skill does and exactly what phrases or commands trigger it.
---
```

Every `SKILL.md` must contain these sections (in any order):

- At least one `## Step N` section describing what Claude does when the skill is triggered
- `## References` — citing every methodology, template, book, or framework the skill draws from

---

## 4. Hard Rules — Do Not Violate

- **Standalone**: a skill must work without any other skill in this repo being installed. No cross-skill references, no shared files, no assumed file structures from another skill.
- **Generic**: no hardcoded project names, team names, service names, or organization-specific content. Skills must work for any software project.
- **Cited**: every methodology or framework used must have a source in `## References`. No uncited frameworks.
- **One file**: each skill is one `SKILL.md`. Do not create additional files inside a skill directory.
- **No implementation code**: skills are instructions for Claude, not code. Do not add Python/JS/shell scripts inside a skill directory (the installer lives at repo root, not inside skills).

---

## 5. Adding a New Skill

1. Create `.claude/<skill-name>/SKILL.md`
2. Write frontmatter with `name`, `category`, `description`
3. Write step-by-step instructions Claude will follow when triggered
4. Add `## References` citing all sources
5. Verify the skill is standalone — grep for any reference to other skill names in this repo
6. Add the skill to the `SKILLS` array in `install.sh`
7. Add a row to the skills table in `README.md`

---

## 6. Modifying an Existing Skill

- Preserve the skill's core intent and trigger behavior unless explicitly asked to change them
- If removing a section or step, confirm with the user first — steps may be load-bearing
- After edits, re-verify the skill is standalone and generic

---

## 7. Updating `install.sh`

When adding a new skill, add its name to the `SKILLS` array:

```bash
SKILLS=(adr concept-quiz repo-context-system <new-skill-name>)
```

---

## 8. Commit Conventions

- Scope commits to one skill or one cross-cutting concern
- Message format: `<type>(<skill>): <what changed>`
  - Types: `add`, `fix`, `refactor`, `docs`, `chore`
  - Examples: `add(adr): initial skill`, `fix(concept-quiz): remove project-specific tables`
- Do not amend published commits

---

## 9. What Claude Must Never Do in This Repo

- Add project-specific content (service names, team names, org-specific tooling) to a skill
- Create cross-skill dependencies
- Modify `install.sh` URLs without confirmation — the `<YOUR_GITHUB>` placeholder must be updated by the human maintainer, not inferred
- Delete a skill without explicit instruction
- Add files outside `.claude/`, `install.sh`, `README.md`, and `CLAUDE.md` without explicit instruction
