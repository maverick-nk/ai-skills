# ai-skills

A collection of Claude Code skills for software engineering workflows. Each skill is a standalone prompt that extends Claude Code with a specific capability — triggered by a slash command or natural language phrase.

Skills are plain markdown files. No dependencies, no build step.

---

## Available Skills

| Skill | Trigger | Description | Examples |
|---|---|---|---|
| [`adr`](.claude/adr/SKILL.md) | `/adr`, "document this decision", "why did we choose" | Creates Architecture Decision Records capturing design choices, alternatives, trade-offs, and concept references | — |
| [`concept-quiz`](.claude/concept-quiz/SKILL.md) | `/concept-quiz`, "quiz me", "test my knowledge" | After each sub-feature, maps implementation to system design concepts and runs an interactive MCQ session with a persistent score log | — |
| [`repo-context-system`](.claude/repo-context-system/SKILL.md) | "set up context", "create the wiki", "document the services" | Sets up a token-efficient context graph (`CONTEXT.md` + `_master.md`) so Claude loads only what each task needs | — |

---

## Install

### Single command — one skill

```bash
curl -fsSL https://raw.githubusercontent.com/maverick-nk/ai-skills/main/install.sh \
  | bash -s -- <skill-name>
```

Replace `<skill-name>` with one of: `adr`, `concept-quiz`, `repo-context-system`.

By default, installs into `.claude/<skill-name>/SKILL.md` in the **current directory**.

To install into a specific project:

```bash
curl -fsSL https://raw.githubusercontent.com/maverick-nk/ai-skills/main/install.sh \
  | bash -s -- <skill-name> /path/to/your/project
```

### Single command — all skills

```bash
curl -fsSL https://raw.githubusercontent.com/maverick-nk/ai-skills/main/install.sh \
  | bash -s -- --all
```

### Manual install

```bash
# Clone the repo
git clone https://github.com/maverick-nk/ai-skills.git

# Copy a skill into your project
cp -r ai-skills/.claude/<skill-name> /path/to/your/project/.claude/
```

### From a local clone

```bash
./install.sh <skill-name> /path/to/your/project
./install.sh --all /path/to/your/project
```

---

## How skills work

Each skill is a file at `.claude/<skill-name>/SKILL.md`. When Claude Code detects a matching trigger phrase or slash command in your session, it loads the skill instructions and follows them.

Skills are **project-scoped** — install them in any project's `.claude/` directory and they activate for that project only. To make a skill available globally, install into `~/.claude/`.

---

## For Individual Developers

### Adding a new skill

1. Fork this repo
2. Create `.claude/<your-skill-name>/SKILL.md`
3. Use the frontmatter schema:

```yaml
---
name: your-skill-name
category: <learning | tooling | workflow | review>
description: One sentence. What it does and when it triggers.
---
```

4. Ensure the skill is **standalone** — no references to other skills in this repo
5. Add a `## References` section citing the sources the skill draws from
6. Submit a pull request — see `CLAUDE.md` for contribution conventions

### Skill design rules

- **Standalone**: each skill must work without any other skill installed
- **Generic**: no hardcoded project names, service names, or team-specific content
- **Cited**: any methodology, template, or framework the skill uses must be credited in `## References`
- **Triggered**: skills must define clear natural-language or slash-command triggers in the frontmatter description

---

## References

### `adr`
- Nygard, Michael. "Documenting Architecture Decisions." Cognitect Blog, 2011. https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
- ADR GitHub organization and catalog: https://adr.github.io/

### `concept-quiz`
- Kleppmann, Martin. *Designing Data-Intensive Applications*. O'Reilly Media, 2017.
- Roediger, H.L. & Karpicke, J.D. "Test-Enhanced Learning." *Psychological Science*, 2006. — basis for retrieval practice / active recall methodology.
- Ebbinghaus, Hermann. *Über das Gedächtnis* (Memory). 1885. — spaced repetition and the forgetting curve.

### `repo-context-system`
- Martraire, Cyrille. *Living Documentation*. Addison-Wesley, 2019. — documentation that evolves alongside code.
- Anthropic. Claude Code documentation: context window management and `CLAUDE.md` conventions. https://docs.anthropic.com/claude-code

---

## Contributing

See [`CLAUDE.md`](CLAUDE.md) for agentic contribution workflows and [`CONTRIBUTING.md`](#) for human contribution guidelines.

Pull requests welcome. Open an issue first for significant new skills.

