---
name: afhl-write-test-code
description: Guide for writing test code. Use this when asked to write test code for given test names.
---

## Role

You are a software engineer that practices Test-Driven Development (TDD).

## Inputs

Provided at skill usage time: One or more test files. If not provided, ask user.

## Context

Treat the following as placeholders as tests that need implementation:
1. Empty test body.
2. Test body containing comments in the format `TODO: <setup | run | assert>: <description>`.

## Action

1. Write test code for each test name.
  * If the comment specifies it is a `setup`, `run` or `assert` step, then implement that step as described.
  * If the comment doesn't specify, use your judgement to determine which step it is and implement it accordingly.
  * If there is no comment, look at the test name and implement the test code based on what you think the test should be doing.
2. Run the test code.
  * Run only the provided test files.
  * Prefer running only the specific implemented test names when the test runner supports it; otherwise run the provided test files.
  * Choose the test command based on project conventions in the repository.
3. Check whether the test code is failing for the right reasons.
  * If a newly implemented test passes unexpectedly, use assertion sabotaging and rerun the test to show a failing result.
  * After demonstrating the failing result from assertion sabotaging, do not switch the assertion back automatically; leave it for the user to personally switch over by leaving the correct assertion commented out with substring "CORRECT_ASSERTION:".
  * If a newly implemented test passes because existing implementation already satisfies it, add a concise comment in that existing implementation noting it is the behavior that made the new test pass.
4. Determine whether each failure is for the right reason.
  * Right reason: assertion/expectation failure or domain validation failure from the new test logic.
  * Not right reason: syntax errors, import/module resolution errors, test framework configuration errors, or unrelated runtime/setup failures.
  * If failure is not for the right reason, fix the test code (within provided test files) so it runs and fails for the right reason.
5. Report execution outcome.
  * Provide a failure summary for each implemented test.
  * Provide a list of blocked items and why.

## Rules

1. Implement tests only in the provided test files.
2. Do not modify unrelated files unless:
  * it is needed to make test code compile
  * it is needed to add a concise comment in existing implementation that made a newly implemented test pass
3. Do not implement code to pass the test.

## Definition of done

1. Test code is written for all test names in the provided test files
2. Test code added runs and each implemented test fails for the right reason (assertion/expectation or domain validation failure).
3. Report includes:
  * Failure summary for each implemented test.
  * Blocked items and why.
