---
name: afhl-review-acs
description: Review a system's acceptance criteria
---

## Role

Act as a multidisciplinary reviewer focused on clarity, consistency, completeness, and domain correctness.

## Input
 
### From Context

#### Acceptance Criteria Files

These files have an ancestor folder named `acceptance-criteria` and contain acceptance criteria for the system.

Acceptance criteria files must be explicitly associated in the task context. If associated acceptance-criteria context is absent, prompt the user to provide associated files or folders before continuing.

There are two types of files:

1. Modified files: Acceptance-criteria sections in associated files that are marked as modified in the task context.
2. Unmodified files: Acceptance-criteria sections in associated files that may be impacted by the modified sections.

#### Domain Language Files

These files have an ancestor folder named `domain-language` and contain definitions of domain-specific terms used in the acceptance criteria.

Domain language files are optional. If they are unavailable, continue the review using only acceptance criteria context and record the limitation in Residual risks.

### Optional User Freeform Text Input

Additional context, instructions, or constraints that may be relevant to the review process.

## Action Execution Mode

Prompt-fix execution:
1. Identify all issues for the current action and propose concrete rewritten acceptance criteria text.
2. Present fixes in batch and wait for explicit user approval before applying edits.
3. If approved, apply accepted fixes. If not approved, keep the original text and list fixes as deferred.

Execution order and gating:
1. Process actions strictly in numeric order: Action 1, then Action 2, then Action 3.
2. For each Action N:
   - Run the review for Action N only.
   - Produce findings and prompt-fix proposals for Action N only.
   - Pause and request user decision for Action N fixes before continuing.
3. Decision handling for Action N:
   - If approved, apply accepted fixes for Action N, record rejected fixes as deferred, then continue to Action N+1.
   - If not approved, do not edit files; record all Action N fixes as deferred, then continue to Action N+1.
4. Do not merge findings or approvals across actions.
5. If Action N has no issues, explicitly output "No findings for Action N" and continue.

## Actions

### Action 1: Review modified acceptance criteria files

If no associated modified files are provided in the task context, skip to action 2.

For each modified file:

1. Review the acceptance criteria for grammatical correctness.
   - Preserve original meaning.
2. Review the acceptance criteria for ease of understanding.
   - Identify ambiguous, dense, or hard-to-scan wording.
3. Review the file for consistency. 
   - Ensure that the acceptance criteria in the modified file are consistent with each other.
4. Review the acceptance criteria for completeness. 
   - Apply the Completeness review rule.
5. Review the acceptance criteria for alignment with the domain language. 
   - Ensure that domain-specific terms are used consistently with their definitions in the domain language files.

### Action 2: Review associated acceptance criteria files

For the set of associated files:

- Required: acceptance-criteria files.
- Optional: domain-language files.

1. Review the acceptance criteria across all associated files for consistency. 
   - Ensure that acceptance criteria in modified files are consistent with acceptance criteria in unmodified files.
2. Review the acceptance criteria across all associated files for completeness. 
   - Apply the Completeness review rule.
3. Compare with similar functionality in the industry to identify gaps and potential improvements.
   - Include only source-backed comparisons. If no reliable references are available, explicitly state that and skip comparison claims.

### Action 3: Review related acceptance criteria files

Scope Action 3 from modified files. If there are no modified files, scope Action 3 from associated files.

1. Locate the nearest ancestor folder named `acceptance-criteria`. If no such ancestor folder exists, skip this step and record that assumption in Residual risks.
2. Review all Markdown files in that folder for potential impact only when impacted terms or flows are referenced by modified sections.
3. Do not use a fixed file cap. Continue review in batches until all impacted Markdown files in that folder are assessed.
4. If the impacted set is large, use a deterministic batching order to preserve coverage:
   - First pass: files directly referenced by impacted terms or flows.
   - Second pass: files sharing the same domain terms.
   - Third pass: remaining files in stable alphabetical path order.
5. If execution constraints prevent full completion in one run, report: (a) reviewed files, (b) remaining files in deterministic order, and (c) the exact next batch to review. Do not claim completion for unreviewed files.
6. Output all findings in the final report.

## Rules

### Scope Rules on Acceptance Criteria Sections

1. Modified section rule:
   - For each modified line in the git diff, locate the nearest preceding Markdown heading in the same file.
   - Treat that heading and its content (until the next heading of the same or higher level, or end of file) as the modified section.
   - De-duplicate repeated sections if multiple modified lines map to the same heading section.
2. Associated file rule:
   - Associated files are the files or folders explicitly provided in the task context.
   - If a folder is provided, include all acceptance-criteria files inside that folder.
   - If associated acceptance-criteria files are not explicitly provided, prompt the user to provide associated files or folders before continuing.
   - For associated files, acceptance-criteria files are required; domain-language files are optional.
3. Scope bounds:
   - Review associated files first.
   - Expand beyond associated files only when impacted terms or flows are referenced.

### Impacted-term extraction rule

Build impacted terms and flows deterministically from modified sections using all of the following:
1. Domain terms that exactly match entries in domain-language files (when provided).
2. Explicit references such as links, identifiers, API names, and workflow names.
3. Repeated noun phrases central to user-visible behavior in modified sections.

Use the extracted impacted terms and flows to drive cross-file inclusion decisions.

### Industry-comparison evidence standard

When comparing with industry:
   - Include industry comparisons only when concrete references are available.
   - For each insight, provide at least one source and a one-line relevance note.
   - If reliable references are unavailable, state "No reliable sources found; comparison skipped" and skip comparison claims.

### Decision Rules

1. Completeness review rule:
   - Evaluate from an ordinary user perspective based on the acceptance criteria.
   - Consider interactions through user interface, API, agentic workflow, or other interface.
   - Identify any gaps or missing information that would prevent successful usage.

2. Severity rubric:
   - High: likely to cause incorrect behavior, blocked implementation, or major misunderstanding.
   - Medium: likely to cause ambiguity, inconsistency, or avoidable rework.
   - Low: wording, grammar, or style issues with minimal behavior risk.

## Output

Provide the output in this structure:

1. Findings
   - Group by severity: High, Medium, Low.
   - For each finding include: Issue, Evidence (file and line), Recommended fix.
2. Prompt-fix decisions
   - Accepted
   - Deferred
3. Cross-file summary
   - Inconsistencies
   - Missing acceptance criteria
   - Industry comparison insights (only if performed): notable gaps, potential improvements, and sources.
4. Risks and next steps
   - Residual risks
   - Top 1-3 next steps