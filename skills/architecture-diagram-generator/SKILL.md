---
name: architecture-diagram-generator
description: Use when the user asks to draw architecture diagrams, system design diagrams, flowcharts, pipeline diagrams, or any technical diagram. Triggers on "draw a diagram", "画个架构图", "visualize the architecture", "create a diagram"
---

# Architecture Diagram Generator

Generates self-contained HTML architecture diagrams using pure CSS/HTML — zero JavaScript dependencies, zero Mermaid, zero CDN. Opens in any browser instantly.

## When to Use

- "draw a diagram of X"
- "visualize the architecture"
- "create a system design diagram"
- "画个架构图"
- "show me the pipeline"

## Why Pure CSS, Not Mermaid

Mermaid has version compatibility issues (v10 vs v11 syntax changes, CDN availability, layout bugs with complex nested subgraphs). Pure HTML/CSS diagrams:
- Render identically in every browser
- No JavaScript rendering delay
- No CDN dependency (works offline)
- Full control over layout and styling
- Hover tooltips are trivial to add

## Diagram Pattern Library

Choose the right pattern based on what the user wants:

### Pattern A: Linear Pipeline (flowchart LR)
Use when: sequential stages, left-to-right flow.
```
[Stage 1] → [Stage 2] → [Stage 3] → [Stage 4]
```

### Pattern B: Layered Architecture (flowchart TB)
Use when: top-down layers, each layer has sub-components.
```
Layer 1 (Input)
    ↓
Layer 2 (Processing)
    ↓
Layer 3 (Output)
```

### Pattern C: Comparison Table (grid)
Use when: side-by-side comparison of 2-4 items.
```
| Item A | vs | Item B |
```

### Pattern D: Hierarchy Tree (d-col + d-row nesting)
Use when: parent-child relationships, org charts, taxonomy.

### Pattern E: Sub-Groups with Labels (d-group)
Use when: components belong to named groups.

## CSS Template

Every generated HTML file must include this base CSS. Copy it verbatim:

```css
:root {
  --bg:#0f172a; --card:#1e293b; --text:#e2e8f0;
  --accent:#38bdf8; --green:#4ade80; --amber:#fbbf24;
  --purple:#c084fc; --pink:#f472b6; --rose:#fb7185;
  --border:#334155;
}
* { margin:0; padding:0; box-sizing:border-box; }
body { background:var(--bg); color:var(--text); font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',system-ui,sans-serif; line-height:1.6; padding:2rem; }
.page-title { text-align:center; color:var(--accent); margin-bottom:0.3rem; }
.page-sub { text-align:center; color:#94a3b8; font-size:0.85rem; margin-bottom:2rem; }

/* Boxes */
.diagram { margin:1.5rem auto; max-width:1100px; background:var(--card); border-radius:12px; padding:2rem; border:1px solid var(--border); overflow-x:auto; }
.d-row { display:flex; gap:1rem; align-items:center; justify-content:center; flex-wrap:wrap; margin:0.8rem 0; }
.d-col { display:flex; flex-direction:column; gap:0.6rem; align-items:center; }
.d-box { background:#1a2332; border:2px solid var(--border); border-radius:8px; padding:0.7rem 1.2rem; text-align:center; font-size:0.8rem; min-width:100px; transition:0.2s; }
.d-box:hover { border-color:var(--accent); }
.d-box.accent { border-color:var(--accent); }
.d-box.green { border-color:var(--green); }
.d-box.amber { border-color:var(--amber); }
.d-box.purple { border-color:var(--purple); }
.d-box.pink { border-color:var(--pink); }
.d-box.rose { border-color:var(--rose); }
.d-box .d-title { font-weight:700; color:var(--text); }
.d-box .d-sub { color:#94a3b8; font-size:0.7rem; margin-top:0.2rem; line-height:1.4; }
.d-box.sm { min-width:70px; padding:0.5rem 0.8rem; font-size:0.72rem; }
.d-box.lg { min-width:160px; }
.d-box.xl { min-width:220px; }

/* Arrows */
.d-arrow { color:var(--accent); font-size:1.3rem; font-weight:700; min-width:30px; text-align:center; display:flex; align-items:center; }
.d-arrow.down { flex-direction:column; }

/* Groups */
.d-group { border:2px solid var(--border); border-radius:10px; padding:1.2rem; background:rgba(30,41,59,0.3); position:relative; margin-top:0.5rem; }
.d-group-title { position:absolute; top:-12px; left:1rem; background:var(--card); padding:0 0.8rem; font-size:0.75rem; color:var(--accent); font-weight:600; }
.d-group.accent { border-color:var(--accent); }
.d-group.green { border-color:var(--green); }
.d-group.amber { border-color:var(--amber); }
.d-group.purple { border-color:var(--purple); }

/* Tables */
.d-table { width:100%; border-collapse:collapse; font-size:0.82rem; margin:1rem 0; }
.d-table th { border-bottom:2px solid var(--accent); text-align:left; padding:0.5rem; }
.d-table td { border-bottom:1px solid var(--border); padding:0.5rem; color:#94a3b8; }

/* Badges */
.d-badge { display:inline-block; padding:0.1rem 0.4rem; border-radius:3px; font-size:0.65rem; font-weight:600; margin:0.1rem; }
.db-blue { background:#1e40af; color:#93c5fd; }
.db-green { background:#065f46; color:#6ee7b7; }
.db-amber { background:#78350f; color:#fcd34d; }
.db-purple { background:#581c87; color:#d8b4fe; }
.db-pink { background:#831843; color:#f9a8d4; }

/* Tooltips */
.d-tip { border-bottom:1px dashed var(--accent); cursor:help; position:relative; color:var(--accent); display:inline-block; }
.d-tip .dt-text { visibility:hidden; opacity:0; position:absolute; z-index:100; bottom:calc(100% + 8px); left:50%; transform:translateX(-50%); background:#0f172a; border:1px solid var(--accent); border-radius:8px; padding:0.6rem 0.8rem; width:280px; text-align:left; font-size:0.72rem; line-height:1.5; transition:0.15s; pointer-events:none; color:var(--text); }
.d-tip .dt-text::after { content:''; position:absolute; top:100%; left:50%; transform:translateX(-50%); border:6px solid transparent; border-top-color:var(--accent); }
.d-tip:hover .dt-text { visibility:visible; opacity:1; }
```

## Color Semantics

Assign colors consistently across ALL diagrams:

| Color | CSS Class | Use For |
|-------|----------|---------|
| Cyan (accent) | `.accent` | Main flow, primary components, user-facing layers |
| Green | `.green` | Success states, verified outputs, correct paths |
| Amber | `.amber` | Warnings, intermediate processing, data stores |
| Purple | `.purple` | External services, third-party, ML/AI components |
| Pink | `.pink` | Security, auth, guardrails, critical paths |
| Rose | `.rose` | Errors, failure modes, deprecated, Tier 1 (lowest) |
| Default (gray border) | (no class) | Neutral, supporting components |

## Output Requirements

Every generated diagram file must:
1. Be a single self-contained `.html` file
2. Open in any browser with zero dependencies
3. Use the CSS template above verbatim
4. Follow color semantics consistently
5. Include the page title and optional subtitle
6. Support hover tooltips on technical terms (optional, add if the user asks)

## Instructions

1. **Ask clarifying questions if needed** — what to draw, how many levels, what to emphasize. One question at a time.
2. **Choose the right pattern** (A-E) based on what the user describes.
3. **Build the HTML** using the CSS template and pattern library.
4. **Save to the project** — default path is `docs/diagrams/<name>.html`. Ask the user if they want a different location.
5. **Open in browser** — run `open <path>` so the user can see it immediately.
6. **Offer to iterate** — "Does this look right? Any adjustments?"

## Quick Reference: Common HTML Snippets

**Horizontal flow:**
```html
<div class="d-row">
  <div class="d-box accent"><div class="d-title">Input</div></div>
  <div class="d-arrow">→</div>
  <div class="d-box green"><div class="d-title">Process</div></div>
  <div class="d-arrow">→</div>
  <div class="d-box accent"><div class="d-title">Output</div></div>
</div>
```

**Vertical flow:**
```html
<div class="d-col">
  <div class="d-box accent lg"><div class="d-title">Layer 1</div></div>
  <div class="d-arrow down">▼</div>
  <div class="d-box green lg"><div class="d-title">Layer 2</div></div>
</div>
```

**Grouped components:**
```html
<div class="d-group accent">
  <div class="d-group-title">Group Name</div>
  <div class="d-row">
    <div class="d-box accent sm"><div class="d-title">A</div></div>
    <div class="d-box accent sm"><div class="d-title">B</div></div>
  </div>
</div>
```

**Hover tooltip:**
```html
<span class="d-tip">term
  <span class="dt-text"><b>Term Explained</b><br/>Plain language explanation here.</span>
</span>
```

**Comparison table:**
```html
<table class="d-table">
  <tr><th>Dimension</th><th>Option A</th><th>Option B</th></tr>
  <tr><td>Feature 1</td><td>Value</td><td>Value</td></tr>
</table>
```

**Badge inline:**
```html
<span class="d-badge db-green">STATUS</span>
```
