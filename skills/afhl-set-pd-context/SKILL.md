---
name: afhl-set-pd-context
description: Guide for setting shared context variables for build-product flow that downstream AFHL skills can rely on.
---

## Role

You are a workflow context initializer for AFHL skills.

## Goal

Set and validate a small, shared set of context variables for the build-product flow.

## Inputs

### Provided at skill usage time

Optional inputs:

| Input name | Description | Accepted format |
| ---------- | ----------- | --------------- |
| Epic URI | Relative epic path under `<repository_root>/.agent_plan` | `epic: <yyyy>/<mm>-<epic_name>` |
| Task URI | Relative task path under `<repository_root>/.agent_plan` | `task: <yyyy>/<mm>-<epic_name>/<task_name>` |
| Root project | Project root path when it cannot be inferred because it is not a repository | `root-project: <absolute_or_relative_path>` |

Input requirements:

1. At least one of `epic` or `task` must be provided.
2. If both are provided, they must be consistent.

## Variables to set

Set the following variables in context output:

- `afhl_task_workspace`
- `afhl_epic_workspace`

## Resolution rules

0. `root_project`
  - If `root-project` is provided, use it.
  - Else default to repository root of the current workspace.

1. `afhl_task_workspace`
  - If `task` is provided, use `<root_project>/.agent_plan/<task>`.
  - Else set to `null`.

2. `afhl_epic_workspace`
  - If `task` is provided, derive from parent folder of `afhl_task_workspace`.
  - Else if `epic` is provided, use `<root_project>/.agent_plan/<epic>`.

3. Consistency when both `task` and `epic` are provided
  - Derive task epic path as parent folder of `<task>`.
  - If derived task epic path does not equal `<epic>`, fail and ask user to correct inputs.

## Actions

1. Parse inputs and enforce input requirements.
2. Resolve workspaces using the resolution rules.
3. Normalize resolved path values to absolute paths.
4. Validate path existence for each non-null workspace:
  - If missing, ask user for confirmation before creating.
  - If confirmed, create missing folder(s) and re-check.
5. Output the context block.

## Output

Output a machine-readable context block for downstream skills:

```text
context:
  afhl_task_workspace: <absolute_path_or_null>
  afhl_epic_workspace: <absolute_path>
checks:
  afhl_task_workspace_exists: <true|false>
  afhl_epic_workspace_exists: <true|false>
```

Output requirements:

1. Use literal `null` for `afhl_task_workspace` when only epic is provided.
2. Keep path values absolute and normalized.

## Acceptance checks

1. Do not modify code files.
2. Do not invent missing paths; ask user when required values are unavailable.
3. Keep variable names stable: `afhl_task_workspace` and `afhl_epic_workspace`.
4. Fail on inconsistent `task`/`epic` inputs; do not auto-correct.
5. Only create missing folders after explicit user confirmation.
6. Both context variables are set (`afhl_task_workspace` may be `null` when only epic is provided).
7. Path existence checks are reported.
8. A machine-readable context block is produced for downstream skills.
