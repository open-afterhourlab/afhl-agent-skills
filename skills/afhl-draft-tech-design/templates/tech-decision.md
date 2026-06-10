# Technical Design Decision

## Scope: Systems and Responsibilities

<!---
Goal: This section is to help your readers understand the systems that are mentioned through the technical decision.

List:
- Name of the system
- Short introduction of their responsibility
- Short explanation why the system is a stakeholder in this design

Reminder: Readers may not have heard of the system or only have surface understanding of the system. Keep it simple to understand.

Example:

```
**Product Discovery Service** 
Responsible for filtering the products based on a certain criteria.
This system needs changing to accomodate for new ways of filtering criteria.

**Sales Service**
Responsible for generating sales report, which is aggregated by product.
This system needs changing to accomodate for new ways of filtering sales by product.
```
-->

## Decision: System Flow

<!--
Goal: This section is to help readers understand:

- How the systems mentioned in the previous section will change because of this decision.
- How this change meets the requirements (both functiona and non-functional acceptance criteria).

Include mermaid markdown (target state and if useful, current state):
- sequence diagram
- class diagram
-->

## Decision: <API | Event > Contracts

<!--
Goal: This section is to help readers understand:
- How the system contracts that will change because of this decision.
- How this change meets the requirements (both functiona and non-functional acceptance criteria).

Illustrate contracts with commonly use specification format, along with examples:
- API (OpenAPI spec)
- Event (AsyncAPI spec)
-->

## Decision: Data Model

<!--
Goal: This section is to help readers understand:
- How the database model / data schema will change
- How this change meets the requirements (both functiona and non-functional acceptance criteria).

Include supporting visuals with mermaid markdown of an Entity Relationship Diagram (ERD).
-->

## Security and Privacy
<!--
Goal: This section is to explain to readers:
- How this decision ensures that the system is still secure and data is protected.
- Any risk that is unaddressed and why it is unaddressed. 
  - If risk needs to be managed, state the plan, how it will be deployed and how it mitigates that risk. 
-->

## Limits

<!--
Goal: This section is to help readers understand the upper limits of the system in scope of this technical decision, the monitoring plans.
Limits could be existing (carried over) or new.

State:
- what the limit is (e.g. Number of images)
- why the limit exist (e.g. rate-limiting on image scanning provider, cost, memory)
- impact of the limit: what will happen if the limit is reached (e.g. system crashes)
- margin: how long do we forecast we have before hitting this limit
- monitoring: how do we monitor how close we are to hitting this limit
- (optional) next steps: optionally state some ideas of what can be done to lift this limit sustainably.

Examples of limits:  performance degradation, concurrent request that may lead to corruption of data etc
-->

## Observability and Monitoring

<!--
Goal: This section is to help readers understand what observability and monitoring that needs to be instrumented.
These are important for monitoring, debuggability, recovery etc.

State:
- What the metric or observability is
- Where it will be emitted to
-->

## Decision Changelog

<!--
Goal: This section is to help readers understand how the decision has evolved before the final decision is committed.

This includes earlier option was shelved into alternatives.
-->