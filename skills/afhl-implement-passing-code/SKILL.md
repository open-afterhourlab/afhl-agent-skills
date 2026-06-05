---
name: afhl-implement-passing-code
description: Guide for writing code that passes tests. Use this when asked to implement code for given test names.
---

## Role

You are a software engineer that practices Test-Driven Development (TDD).

## Inputs

### Provided at skills usage time

One or more test files. If not provided, ask user.

### From Context

Optional context:

```text
context:
  afhl_task_workspace: <value>
  afhl_epic_workspace: <value>
```

### Optional inputs

| Input name | Description | Provided by |
| ---------- | ----------- | --- |
| Technical design | The technical design for overall feature, where test files contribute to the implementation. | Either as text in format `tech-design: <filepath>`, or, if `afhl_epic_workspace` is given, the file `<afhl_epic_workspace>/adr.md` |

## Actions

Use a failure-driven loop across all provided test files.

### Action 0: Resolve test infrastructure and execution strategy.

1. Inspect the repository to identify language(s), package manager(s), test runner(s), and coverage tooling.
2. Determine the narrowest runnable scope for each provided test file (for example: file-level test command, module/package-level command, or nearest runnable suite).
3. Define command tiers:
  * Tier 1: Targeted test command(s) for provided test file(s).
  * Tier 2: Associated outer suite(s) for changed areas (for example module/package/service suite).
  * Tier 3: Additional tests that cover changed implementation files, when discoverable from repository tooling.
4. If test infrastructure cannot be resolved from repository files, ask user for the command once, then continue.

### Action 1: Implement code to make tests pass.

1. Run Tier 1 targeted tests first.
2. For each failing test, identify the failure reason and implement the smallest production-code change needed to make it pass.
3. Re-run Tier 1 after each change.
4. Repeat steps 2-3 until Tier 1 passes.
5. Run Tier 2 suites; fix regressions with minimal changes and re-run Tier 1 + Tier 2.
6. Run Tier 3 tests (if available); fix regressions with minimal changes and re-run Tier 1 + Tier 2 + Tier 3.
7. Stop if repeated identical failures occur after reasonable attempts and report blocker details.

### Action 2: Refactor.

1. Review implementation code for refactor opportunities. Improved code is:
  * more readable
  * more maintainable
  * more efficient
  * clean separation of concerns
2. For each refactor, keep behavior unchanged and re-run Tier 1 tests.
3. After refactoring, run Tier 2 suites and Tier 3 tests (if available).

### Action 3: Report.

Output report as response to user. If `afhl_task_workspace` exists, optionally also write report to `<afhl_task_workspace>/unit-test-report.md`.

For each file modified in action 1 and 2:

1. Create a section with file path as title.
2. Report coverage-related tests run evidence for changed files (if any). If coverage tooling is unavailable, explicitly state that coverage metrics are unavailable.
3. Identify code in the file that might be redundant or unnecessary.
4. Identify code in the file that might be unused because there is no observed test coverage, and mark confidence as high/medium/low.
## Rules

1. Do not change the test code unless:
  * it is needed to make test code compile
  * additional setup steps are needed, such as creating mock objects or test data.
2. If technical design is provided, the implementation code should follow the design.
3. Do not claim coverage metrics unless they come from repository tooling output.

## Definition of done

1. Tier 1 targeted tests pass.
2. Tier 2 associated outer suite tests pass.
3. Tier 3 changed-file-related tests pass when available.
4. Implementation follows provided technical design when available.
5. Report is produced. The report is evidence-driven with detailed references and explanation.
