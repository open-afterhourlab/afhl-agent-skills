---
name: afhl-draft-hypothesis
description: Draft a hypothesis for a product feature or system design.
---

## Role

Act as one of the following roles, depending on the type of hypothesis being drafted:

- User experience: Product Manager or UX Designer
- Domain model: Product Manager or Domain Expert
- User interface: Product Manager or UX Designer
- Technical: Product Manager or Software Engineer

In addition, also act as:

- A product software engineer that advises on the technical feasibility of the hypothesis, and provides input on the technical design and implementation considerations.
- A statistician that advises on the design of experiments and statistical analysis of the results, and provides input on the data collection and analysis considerations.

## Inputs

Execution mode as input text in format `mode: <value>`, where `<value>` is one of:

* `blank`: Create a blank hypothesis document from template.
* `hint` (default): Create a hypothesis document from template, and pre-fill it with small hints based on the provided information.
* `draft`: Create a hypothesis document from template, and fill it with best-effort content based on the provided information.
* `refine`: Refine an existing hypothesis document with best-effort content based on the provided information.

If no `mode` is provided, default to `hint` mode.

Title of the hypothesis as input text in format `title: <value>`, where `<value>` is a short descriptive title of the hypothesis.

If no `title` is provided, prompt the user to provide a title before continuing.

### Optional inputs

| Input name | Description | Provided by |
| ---------- | ----------- | --- |
| Output directory | Directory where the hypothesis file should be created/refined | In format `output_dir: <filepath>` |
| OKR / Business Outcome | The hypothesis is trying to assist with formulating a plan towards achieving the OKR / business outcome | Either as part of prompt or in format `outcome: <filepath>` |

## Actions

### Action 0: Setup

1. Resolve the target directory as follows:
    - If `output_dir` is provided, use it.
    - Otherwise, use the current directory.
2. Build the filename as `{mm}-{title}.md` where `{mm}` is the 2-digit month number (`01`-`12`) from the current date.
3. If the file does not exist in the target directory, create it using the template [hypothesis.md](./templates/hypothesis.md).
4. If the file already exists, reuse that file and continue with refinement based on the selected mode.
5. Report to user the file path created or reused.

### Action 1: Shared prefill pipeline

If execution mode is `mode: blank`, skip to completion after Action 0.

1. Analyze the sections, comments, and structure of the hypothesis file created in Action 0.
2. Analyze the prompt that the user has given, and identify relevant information that can be used to pre-fill the hypothesis document.
3. If an `outcome` filepath is provided, read it and extract only relevant information for prefill.
4. You may ask for more information from the user if you need more context to pre-fill the hypothesis document.

### Action 2a: Hint mode

If execution mode is not `mode: hint` skip to next action.

1. For each section of the hypothesis document, if relevant information is identified from the inputs, pre-fill that section with a small hint.
2. Hint mode must avoid assumptions. If a section has insufficient information, leave it unfilled.
3. Small hints are for the user to expand on the details of hypothesis design.
4. Small hints can be either:
    * keywords or short phrases only that invoke thought  (no more than 5-10 words)
    * or, a question that prompts exploration for the user to expand on the details or clarify the assumptions.
5. On reruns, refine existing content in-place by adding or improving hints according to new inputs while preserving user-authored intent.

### Action 2b: Draft mode

If execution mode is not `mode: draft` skip to next section.

1. For each section of the hypothesis document, if relevant information is identified from the inputs, pre-fill that section with best-effort content based only on provided information.
2. Do not make assumptions in draft mode. If any section cannot be filled with provided information, add a placeholder question in that section.
3. On reruns, refine and expand existing draft content based on new inputs while keeping previously captured valid details.

### Action 2d: Refine mode

Provide suggestions to refine:

1. As a statistician, provide a summary of the hypothesis design and any potential risks or limitations that may affect the validity of the results.
2. As a product manager, provide a summary of the hypothesis design and any potential risks or limitations that may affect the business outcome.
3. As a designer, provide a summary of the hypothesis design and any potential risks or limitations that may affect the user experience.
4. As a software engineer, provide a summary of the hypothesis design and any potential risks or limitations that may affect the technical feasibility or implementation of the hypothesis.

In `refine` mode, you may ask for more information from the user if you need more context to refine the hypothesis document.