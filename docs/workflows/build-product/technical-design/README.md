# Technical Design

> [!WARNING]
> Under construction

## Pre-Condition

| Condition | Description |
| --------- | ----------- |
| Domain Language (DL) | Agreed upon ubiquitous language for the domain being designed |
| Acceptance Criteria (AC) | Agreed functional and non-functional acceptance criteria |
| UI Design | Just enough to demonstrate key areas of how the user will interact with our system through the frontend that will impact architecture. <br/> A 50% draft that illustrate the key architecture components but lack the UI positioning and styling is fine. |

## Steps

### Step: Setup Task Context

Optional.

This sets up where your epic folder is to allow:

* Additional context about the overall feature to be discovered (e.g. criteria)
* Write the content relating to technical design.

Run [Skill: afhl-set-pd-context](../../../../skills/afhl-set-pd-context/) with `epic: <yyyy>/<mm>-<epic name>`

### Step: Summarise DL and AC

1. Run the skill [afhl-summarise-criteria](../../../../skills/afhl-summarise-criteria/) which will look at the changeset relating to Domain Language changes, and Acceptance Criteria changes and summarise it. This helps set the context for yourself as you embark on this journey, and also help your agent progressively discover when reviewing your design.

> [!TIP]
> If the the AC and DL are still being updated, it is worth re-running the task to regenerate the summary to keep it up to date.

**Output**: `<epic folder>/criteria.md`

### Step: Draft Technical Design

1. Run the skill [afhl-draft-tech-design](../../../../skills/afhl-draft-tech-design/) with either `mode` of `blank`, `hint` or `draft` to content for technical design.
2. Open the `tech-decision.md` and start to refine it. You can also start with `tech-alternatives.md` to list your options, and then move the best option into `tech-decision.md` once its clear.