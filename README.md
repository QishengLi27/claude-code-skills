# Claude Code Skills

My personal collection of Claude Code skills for daily development workflows.

## What are Skills?

Skills are reusable instruction documents that teach Claude Code how to perform specific tasks. Each skill is a `SKILL.md` file in a named directory. When you type `/<skill-name>` in Claude Code, the skill's instructions are loaded and followed.

## Structure

```
claude-code-skills/
├── README.md
├── install.sh               # Deploy skills to ~/.claude/skills/
├── templates/
│   └── SKILL.template.md    # Template for creating new skills
└── skills/
    ├── github-repo-manager/
    │   └── SKILL.md         # Git repo setup, cleanup, README generation
    └── interview-prep-generator/
        └── SKILL.md         # JD → project cross-reference, STAR stories
```

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/QishengLi27/claude-code-skills.git
cd claude-code-skills

# 2. Install skills
chmod +x install.sh
./install.sh

# 3. Restart Claude Code, then try:
# /github-repo-manager
# /interview-prep-generator
```

## How `install.sh` Works

Creates symlinks from this repo's `skills/` directory to `~/.claude/skills/`. 

This means:
- **Edit in the repo** → changes are live immediately (symlink, not copy)
- **Git version control** → all skill changes tracked in this repo
- **`git pull`** → sync skills from another machine

```bash
./install.sh                          # Install all skills
./install.sh github-repo-manager      # Install just one
```

## Creating a New Skill

```bash
# 1. Copy the template
cp templates/SKILL.template.md skills/my-new-skill/SKILL.md

# 2. Edit the skill
#   - Update frontmatter (name, description)
#   - Write instructions

# 3. Install and test
./install.sh my-new-skill

# 4. In Claude Code: /my-new-skill

# 5. Commit and push
git add skills/my-new-skill/
git commit -m "feat: add my-new-skill"
git push
```

## Skills Included

### github-repo-manager
Prepares, cleans, and publishes GitHub repositories.
- `/github-repo-manager` — trigger manually
- Auto-triggered by: "push to GitHub", "clean up this repo", "write a README"

### interview-prep-generator
JD → project cross-reference with code-level evidence, STAR stories, gap analysis.
- `/interview-prep-generator` — trigger manually
- Auto-triggered by: "prep me for this JD", "interview prep"

## Design Principles

1. **One skill, one job** — each skill does one thing well
2. **Auto-trigger keywords** — skills respond to natural language, not just slash commands
3. **Project-aware** — skills read the actual project code, not just templates
4. **Checklist-driven** — skills use checklists for reliability (no step skipped)
5. **Git-tracked** — this repo is the source of truth for all skills
