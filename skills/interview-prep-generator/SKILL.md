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

For EACH requirement, search the project for matching evidence:

```
Search order:
1. CLAUDE.md / AGENTS.md — architecture overview
2. src/**/*.py — implementation code
3. docs/superpowers/diagrams/*.html — architecture diagrams
4. docs/superpowers/specs/*.md — design documents
5. tests/ — test coverage as evidence
```

Generate:

```
REQ → Project Evidence Matrix:

[REQ-01] "Document parsing pipeline"
    ✅ FOUND: docs/superpowers/diagrams/doc-intelligence-platform.html → Tab "Doc Parsing"
    ✅ FOUND: 4-tier architecture (OCR → Structured → VLM → Multimodal LLM)
    ✅ FOUND: Tier comparison table with MinerU, LlamaParse, ColPali, GPT-4V

[REQ-02] "Agentic workflow orchestration"
    ✅ FOUND: backend/graph/nodes.py → LangGraph StateGraph with 8 nodes
    ✅ FOUND: Conditional routing (classify_intent → route → tool → reply → validate)
    ✅ FOUND: Self-correction loop (validate_reply with max 2 retries)
    ✅ FOUND: Context compression (2-pass: sliding window + token budget)

[REQ-05] "Prompt Engineering, Few-shot, CoT"
    ✅ FOUND: backend/graph/nodes.py → _REPLY_PROMPT + _STRICT_REPLY_PROMPT
    ⚠️ WEAK: No CoT or Few-shot examples in actual implementation
    ⚠️ FILL: Mention the CoT design for Datataxon's extraction.py
```

Score each: ✅ Strong evidence / ⚠️ Partial / ❌ Gap

### Phase 3: STAR Story Generation

For each ✅ or ⚠️ requirement, generate a STAR story from the ACTUAL code:

```
[REQ-02] "Agentic workflow orchestration"
    S: The e-commerce agent used a ReAct loop — LLM decided its own path,
       leading to inconsistent tool calls and hallucinated routing.
    T: I was responsible for migrating to a deterministic agent architecture
       that could be audited and debugged.
    A: I chose LangGraph StateGraph — every node is a pure function State→State.
       Conditional routing replaces LLM-decided tool selection. Context
       compression handles multi-turn conversations. A validation loop
       (LLM auditor → retry → stricter prompt) catches hallucinations.
       PostgreSQL checkpointing persists state across sessions.
    R: The agent now follows deterministic paths. Every tool call is
       traceable. The self-correction loop catches unverified claims.
       SSE streaming provides real-time token output.
    Code: backend/graph/nodes.py, backend/graph/agent_graph.py
```

### Phase 4: Gap Analysis + Interview Strategy

```markdown
## Gaps to Address
| JD Requirement | Your Evidence | Risk | Mitigation |
|---------------|--------------|------|-----------|
| "Document parsing" | Design only (HTML diagram) | Medium — no running code | Mention doc-intelligence-demo project |
| "Few-shot/CoT" | Design (extraction.py CoT) | Low — you can explain the approach | Show reasoning.py's CoT prompts |

## Questions You Should Ask
- "What document types and languages does the platform handle?"
- "What's the latency requirement for batch document processing?"
- "Does the team use pre-built chunks or custom ingestion?"
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

1. **Every claim MUST cite a file.** Not "I designed X" but "I designed X (see `backend/graph/nodes.py:88-132`)." If the interviewer asks "how?" you have the code.
2. **Be honest about gaps.** A gap with a clear mitigation plan is better than pretending you have evidence you don't.
3. **Read the ACTUAL code, not just docs.** The JD→code mapping must be based on reading source files, not assuming what's there.
4. **Generate at least 8 STAR stories.** Each story maps to 1-3 JD requirements. A story can serve multiple behavioral questions.
