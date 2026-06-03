---
name: afhl-set-task-context
description: Guide for setting shared task context variables that downstream AFHL skills can rely on.
---

## Role

You are a workflow context initializer for AFHL skills.

## Goal

Set and validate a small, shared set of context variables before implementation or test-writing skills run.

## Inputs

### Provided at skill usage time

Optional inputs:

| Input name | Description | Accepted format |
| ---------- | ----------- | --------------- |
| Task URI | Relative task path under `<repository_root>/.agent_plan` | `task: <yyyy>/<mm>-<epic_name>/<task_name>` |
| Root project | Project root path when it cannot be inferred | `root-project: <absolute_or_relative_path>` |

## Variables to set

Set the following variables in context output:

- `afhl_task`
- `afhl_task_workspace`
- `afhl_epic_workspace`

## Resolution rules

1. `afhl_task`
  - Use provided `task` value if present.
  - If missing, ask user for it.

2. `afhl_task_workspace`
  - `<root_project>/.agent_plan/<task>`

4. `afhl_epic_workspace`
  - Parent folder of `afhl_task_workspace`.

## Actions

### Action 1: Collect and normalize input

1. Parse provided inputs.
2. Normalize all paths to workspace-relative or absolute paths consistently.
3. Ask for missing required input (`task`) if not provided.

### Action 2: Validate resolved paths

1. Check whether `afhl_task_workspace` exists. If it doesn't, offer user to create it.

### Action 3: Output context block

Output a machine-readable context block for downstream skills:

```text
context:
  afhl_task: <value>
  afhl_task_workspace: <value>
  afhl_epic_workspace: <value>
checks:
  afhl_task_workspace_exists: <true|false>
```

## Rules

1. Do not modify code files.
2. Do not invent missing paths; ask user when required values are unavailable.
3. Keep variable names stable so other skills can depend on them.

## Definition of done

1. All context variables are set.
2. Path existence checks are reported.
3. A context block is produced for downstream skills.
