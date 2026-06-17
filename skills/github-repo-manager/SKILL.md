---
name: github-repo-manager
description: Use when the user wants to initialize a git repo, push to GitHub, clean up a repo before sharing, generate README.md, or manage multi-project git workflows
---

# GitHub Repo Manager

Prepares, cleans, and publishes GitHub repositories at production quality.

## When to Use

- "push this to GitHub"
- "create a new repo for this project"
- "clean up this repo before I share it"
- "what should my .gitignore look like?"
- "write a README for this"
- "make this project interview-ready"

## Capability Map

| User says | Skill does |
|-----------|-----------|
| "new repo, push to GitHub" | `git init` → `.gitignore` → `README.md` → commit → push |
| "clean up this repo" | Scan for binary artifacts, temp files, experiment residue, redundant docs → `git rm` → update `.gitignore` → commit |
| "write me a README" | Read project structure → generate tailored README with architecture, quickstart, tech stack |
| "make this interview-ready" | Full cleanup + README + check for secrets in history |
| "what should I commit?" | `git status` analysis → suggest what to add vs. what to .gitignore |

## Repo Cleanup Checklist

### Must Remove
- Database binary files (`*.sqlite3`, chroma/pgvector artifacts)
- Experiment directories (`experiments/`)
- `__pycache__/` and `*.pyc`
- Virtual environments (`venv/`)
- API keys, tokens, secrets in any file
- Files from unrelated projects
- Test cache/eval results (`.pkl`, `eval_results.json`)
- Empty placeholder directories with only README.md

### Must Update
- `.gitignore` — add patterns for all binary artifacts found
- `.env.example` — exists, has all needed vars, no real keys
- `README.md` — accurate, has quickstart, has architecture summary

## .gitignore Template

```gitignore
# Python
__pycache__/
*.pyc
*.pyo
*.egg-info/

# Virtual environments
venv/
.venv/

# Environment (contains secrets)
.env

# Database / Binary artifacts
*.sqlite3
*.db
*.pkl
data_level0.bin
header.bin
length.bin
link_lists.bin

# Experiments
experiments/

# Eval artifacts
eval_results.json

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# AI
.claude/

# Generated output
output/
dist/
build/
```

## README.md Generator

When generating a README, scan the project and fill in:

```markdown
# [Project Name]

[One-line description]

## Architecture
[3-5 line description of the system flow + key design decisions table]

## Quick Start
```bash
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env  # edit with your API key
python demo.py
```

## Project Structure
[Directory tree with descriptions]

## Tech Stack
| Layer | Technology | Why |
|-------|-----------|-----|
```

## Commit Conventions

```
feat: add [feature]
fix: fix [bug]
refactor: simplify [component]
docs: add [documentation]
cleanup: remove [what]
build: add [dependency]
test: add test for [what]
```

## Pre-Push Safety Check

1. `git status` — review staged files
2. No `.env` with real keys
3. No binary artifacts in staging
4. `.gitignore` covers generated files
5. `README.md` is accurate
6. Remote URL correct (`git remote -v`)

## User Context

The skill should infer the GitHub username from `git config user.name` or `git remote -v`, and detect active repos from the current working directory. Never hardcode personal information.
