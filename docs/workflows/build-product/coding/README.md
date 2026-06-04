# Coding

> [!WARNING]
> Under construction

Test Driven Development (TDD) centered SDLC.

## Pre-Condition

| Condition | Description |
| --------- | ----------- |
| Technical Design | High level of the technical implementation |

## Overview

## Steps

### Step: Setup Task Context

Optional.

This sets up where your task folder is to allow:

* Additional context about the overall feature to be discovered (e.g. technical design)
* Additional context about the task to be discovered (e.g. scope of task)
* Write outputs for sequencing of steps.

Run [Skill: afhl-set-task-context](../../../../skills/afhl-set-task-context/) 

### Step: Implement - Write Test Specs

> [!Note]
> Manual step for now.
> Automated future: Identify relevant program files, pair the ACs and generate test names.

Instead of writing a markdown file (i.e. as text), its the same effort to write the spec in code placeholders.

1. Identify a place of the program that needs changing.
2. Add an empty test (with test name only) corresponding to the AC to validate.
3. Optional: If you want to steer the agent more specifically, you can write, as comments exactly what needs to be done:
   * `// TODO: setup: <description>`
   * `// TODO: run: <description>`
   * `// TODO: assert: <description>`

### Step: Implement - Write Test Code

This is the red stage of TDD

1. Associate the test file that you want the agent to operate on in the context.
2. Run [Skill: afhl-write-test-code](../../../../skills/afhl-write-test-code/). This will write the test code for you, that should fail.
3. Review and commit.

### Step: Implement - Write Code

This is the green and refactor stage of TDD.

1. Associate the test file that you want the agent to implement the code for.
2. Optional: You can associate a technical design via the input text `tech-design: <filepath>`.  If you have setup task context earlier, it should pick up the `adr.md` file.
3. Run [Skill: afhl-implement-passing-code](../../../../../afhl-agent-skills/skills/afhl-implement-passing-code/)
4. Review and stage changes.
5. Continue to guide agent for more changes and stage at every iteration.
6. Once satisfied, commit ammend to batch the test+code as a changeset.

### Step: Implement - Repeat

Repeat the TDD test-code cycle until all implementation is complete.