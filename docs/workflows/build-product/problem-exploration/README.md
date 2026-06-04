# Problem Exploration

> [!WARNING]
> Under construction

## Outcome: Domain Language

Artifact: As markdown files grouped under a folder `domain-language`.

## Outcome: Acceptance Criteria (ACs)

Artifact:   As markdown files grouped under a folder `acceptance-criteria`.

### 1 - Write AC

1. Best effort, write the acceptance criteria. This could be modifying existing acceptance criteria.
2. Review and commit.

#### 2 - Review AC

1. Associate the modified AC files that you want the agent to review.
2. Associate the related AC files that you want the agent to see if the modified AC will impact
3. Associate the domain language files that you want the agent to use to review your AC.
4. Run [Skill: afhl-review-acs](../../../../skills/afhl-review-skills/), and optionally you can provide additional instructions to the agent for specific checks.
5. Review and stage changes.
6. Continue to guide agent for more changes and stage at every iteration.
7. Once satisfied, commit ammend to batch the test+code as a changeset.
