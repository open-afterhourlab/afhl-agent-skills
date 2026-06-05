---
name: afhl-summarise-criteria
description: Populate the file with a summary of the referenced changes.
---

## Role

Act as an analyst focused on extracting and condensing key information from the referenced external changes.

## Inputs

### From Context

Optional context:

```text
context:
  afhl_epic_workspace: <value>
```

If `afhl_epic_workspace` is not provided, prompt the user to provide it before continuing.

## Changeset Validation and Resolution

A changeset is either a pull request or a commit that contains changes to the codebase.

### Missing Value Rules

Normalize the Proposed Changeset value by trimming whitespace and lowercasing for token checks.

Treat a Proposed Changeset as missing when it is:

1. Empty.
2. One of `N/A`, `n/a`, `none`, `-`, `TBD`.
3. Only an HTML comment placeholder (for example `<!-- ... -->`).

### Valid Value Rules

A Proposed Changeset is valid when it is one of:

1. A pull request URL.
2. A commit URL.
3. A commit SHA that can be resolved in the target repository.

If the value is present but invalid, stop and ask the user to correct it.

### Resolution Defaults

Resolve and inspect changesets using this fallback order:

1. `gh` CLI.
2. GitHub API.
3. `git` CLI.

## Actions

### Action 1: Ensure criteria file exists

If there is a `criteria.md` file in the `afhl_epic_workspace` directory, continue to action 2.

If not:

1. Create a `criteria.md` file in the `afhl_epic_workspace` directory using the template [criteria.md](./templates/criteria.md)
2. Prompt the user to review and edit the file as needed.
3. Wait for explicit user confirmation before continuing to action 2.

### Shared Procedure: Summarise One Section

Given a target section, Proposed Changeset field, and folder filter:

1. Read the Proposed Changeset value for that section only.
2. If the value is missing per the rules above, skip the section.
3. If the value is present but invalid, stop and ask the user to correct it.
4. Resolve and inspect the changeset using the Resolution Defaults.
5. Find markdown files under the target folder in that changeset.
6. Replace content under the section's `Summary` subheading with a concise summary.
   * Include a generation timestamp in ISO 8601 UTC format (for example `2026-06-05T09:30:00Z`).
   * If no matching markdown files are found, write a one-line summary stating no matching markdown changes were found, with timestamp.

### Action 2: Summarise Domain Language Changes

In the `Domain Language` section of the `criteria.md` file:

1. Run the Shared Procedure with:
   * Section: `Domain Language`
   * Folder filter: `domain-language`
2. If skipped because the value is missing, continue to action 3.

### Action 3: Summarise Acceptance Criteria Changes

In the `Acceptance Criteria` section of the `criteria.md` file:

1. Run the Shared Procedure with:
   * Section: `Acceptance Criteria`
   * Folder filter: `acceptance-criteria`
2. When summarising, output in the format `<acceptance criteria URI>: <summary of the change>`
   *  The acceptance criteria URI is the `**filepath from acceptance-criteria folder (without .md)**/**heading's code**` (for example `user-registration/registration-form/a1/a2/b1/c1`).

## Definition of Done

1. A `criteria.md` file exists in the `afhl_epic_workspace` directory.
2. The agent uses the `Domain Language` Proposed Changeset only for the `Domain Language` summary.
3. The agent uses the `Acceptance Criteria` Proposed Changeset only for the `Acceptance Criteria` summary.
4. For each valid external change referenced, a summary is added to the relevant `Summary` section in `criteria.md`.
5. Each generated summary is under the section's `Summary` subheading and includes a generation timestamp in ISO 8601 UTC format.



