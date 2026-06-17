---
name: interview-prep-generator-enhanced
description: JD → Project cross-reference, generates STAR stories from actual code, flags skill gaps
---

# Interview Prep Generator (Project-Aware Enhanced)

> Save this as `~/.claude/skills/interview-prep-generator/SKILL.md` (replace existing).

## When to Use

Trigger when the user:
- Pastes a job description and says "prep me for this"
- Mentions "interview prep" + has a project open
- Asks "how do I answer X based on my project?"

## How It Works — 4 Phases

### Phase 1: JD Extraction

Extract every concrete requirement from the JD as a checklist item. Categorize:

```
REQUIREMENT MAP:
[REQ-01] "Document parsing pipeline"         → Category: System Design
[REQ-02] "Agentic workflow orchestration"      → Category: AI/Agent Engineering
[REQ-03] "Multi-agent collaboration"           → Category: AI/Agent Engineering
[REQ-04] "AI Harness — eval, versioning"       → Category: MLOps
...
```

### Phase 2: Project Cross-Reference

For EACH requirement, search the current project for matching evidence:

```
Search order:
1. CLAUDE.md / AGENTS.md — architecture overview
2. Source files — implementation code
3. docs/ — design documents, architecture diagrams
4. tests/ — test coverage
```

Output format (use ACTUAL file paths found, never hardcoded examples):

```
[REQ-XX] "JD requirement text"
    ✅ FOUND: <path/to/actual/file> → <what it demonstrates>
    ✅ FOUND: <path/to/another/file> → <what it demonstrates>
    ⚠️ WEAK: <what's missing>
```

Score each: ✅ Strong / ⚠️ Partial / ❌ Gap

### Phase 3: STAR Story Generation

For each ✅ or ⚠️ requirement, generate a STAR story grounded in the ACTUAL project code:

```
S: [Situation — what problem existed, with context]
T: [Task — what you were responsible for]
A: [Action — what you specifically did, citing actual files]
R: [Result — what changed, with metrics if available]
Code: [actual file paths in the project]
```

Each story must cite specific files as evidence. Never use generic placeholders — read the actual code and build the story around it.

### Phase 4: Gap Analysis + Interview Strategy

```markdown
## Gaps to Address
| JD Requirement | Your Evidence | Risk | Mitigation |
|---------------|--------------|------|-----------|
| [Weak area 1] | [Current evidence] | [Risk level] | [How to address in interview] |
| [Weak area 2] | [Current evidence] | [Risk level] | [How to address in interview] |

## Questions You Should Ask
- Based on JD gaps and the role's tech stack, generate 3-5 intelligent questions
```

## Output Format

```markdown
# INTERVIEW PREP: [Role] at [Company]

## 1. JD → Project Evidence Matrix
[Table: Requirement | Category | Evidence | Strength]

## 2. Your STAR Story Bank
[5-8 stories, each mapped to 1-3 JD requirements, with actual code references]

## 3. Technical Deep-Dive Answers
[For each JD technical keyword: 3-sentence answer + where in your code]

## 4. Gap Analysis
[What you don't have evidence for → how you'll answer]

## 5. Questions to Ask
[Role-specific, based on JD gaps]

## 6. "Tell Me About Yourself" Script
[2-minute pitch mapping your projects to their JD]
```

## Critical Rules

1. **Every claim MUST cite a file.** Not "I designed X" but "I designed X (see `path/to/file.py:88-132`)." If the interviewer asks "how?" you have the code.
2. **Be honest about gaps.** A gap with a clear mitigation plan is better than pretending you have evidence you don't.
3. **Read the ACTUAL code, not just docs.** The JD→code mapping must be based on reading source files, not assuming what's there.
4. **Generate at least 8 STAR stories.** Each story maps to 1-3 JD requirements. A story can serve multiple behavioral questions.
