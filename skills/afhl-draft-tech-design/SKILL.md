---
name: afhl-draft-tech-design
description: Draft a technical design for a system or feature.
---

## Role

Act as a technical lead who has the following traits:
- Experienced in designing scalable and maintainable systems.
- Proficient in communicating complex technical concepts clearly and in data-driven ways.
- Skilled in identifying potential challenges and proposing effective solutions.
- Knowledgeable about best practices in software architecture and design patterns.
- Deep understanding of the challenges of installing, upgrading, and configuring software and systems for customers.
- Platform thinking.
- Domain-driven design practitioner.
- Agile mindset.
- Quality focus.
- Product mindset. Customer focus.

## Inputs

Execution mode as input text in format `mode: <value>`, where `<value>` is one of:

* `blank`: Create a blank technical design document from template.
* `hint` (default): Create a technical design document from template, and pre-fill it with small hints based on the provided information.
* `draft`: Create a technical design document from template, and fill it with best-effort content based on the provided information.

If no `mode` is provided, default to `hint` mode.

Mode validity rules:
- `blank` mode is valid without `afhl_epic_workspace`.
- `hint` and `draft` modes require `afhl_epic_workspace`. If it is missing, fail with a clear validation error.

### From Context

Optional context:

```text
context:
  afhl_epic_workspace: <value>
```

### Optional inputs

| Input name | Description | Provided by |
| ---------- | ----------- | --- |
| Technical design | The technical design for overall feature, where test files contribute to the implementation. | Either as text in format `tech-design: <filepath>`, or, if `afhl_epic_workspace` is given, the file `<afhl_epic_workspace>/tech-decision.md` |
| Criteria | Domain language, acceptance criteria (functional and non-functional) and/or user design for the feature. | Either as text in format `criteria: <filepath>`, or, if `afhl_epic_workspace` is given, the file `<afhl_epic_workspace>/criteria.md` |

## Actions

### Common rules

1. For conflicting content between technical design and criteria artifacts, choose the criteria artifact (`criteria` input) for the conflicting content.
2. If a conflict is resolved by choosing one artifact over the other, report that a conflict exists and which artifact was chosen.

### Action 0: Setup

1. Create a `tech-decision.md` file in the `afhl_epic_workspace` directory using the template [tech-decision.md](./templates/tech-decision.md), only if the file is missing.
2. Create a `tech-alternatives.md` file in the `afhl_epic_workspace` directory using the template [tech-alternatives.md](./templates/tech-alternatives.md), only if the file is missing.
3. Report to user the files created on their behalf.

### Action 1: Shared prefill pipeline

If execution mode is `mode: blank`, skip to completion after Action 0.

1. Analyze the sections, comments, and structure of `tech-decision.md` created in Action 0.
2. Analyze both artifacts (technical design and criteria), and identify relevant information that can be used to pre-fill the technical design document.
  - If the artifacts contain links, follow those links and analyze the content for relevant information as well.
3. Apply Common rules for conflict resolution and reporting.

### Action 2a: Hint mode

If execution mode is not `mode: hint` skip to next action.

1. For each section of the technical design document, if relevant information is identified from the inputs, pre-fill that section with a small hint.
2. Hint mode must avoid assumptions. If a section has insufficient information, leave it unfilled.
3. Small hints are for the engineer to expand on the technical design.
4. Small hints can be either:
    * keywords or short phrases only that invoke thought  (no more than 5-10 words)
    * or, a question that prompts exploration for the engineer to expand on the technical design.

### Action 2b: Draft mode

If execution mode is not `mode: draft` skip to next section.

1. For each section of the technical design document, if relevant information is identified from the inputs, pre-fill that section with best-effort content based only on provided information.
2. Do not make assumptions in draft mode. If any section cannot be filled with provided information, add a placeholder question in that section.

### Action 3: Technical alternatives

If execution mode is `mode: blank`, skip to next section.

1. Fill the `tech-alternatives.md` document with technical alternatives based on the provided information, one section per alternative.
2. For each alternative, provide a brief description, pros and cons, and any relevant trade-offs.
3. If the `mode: hint` is selected, provide only brief descriptions and high-level pros and cons.
4. If the `mode: draft` is selected, provide more detailed descriptions and in-depth pros and cons, including potential implementation approaches and considerations. 