# Day 46 – Reusable Workflows & Composite Actions MCQs

## Overview

This folder contains a practice MCQ test for **Day 46 – Reusable Workflows & Composite Actions**.

The test is based on GitHub Actions concepts including:

- Reusable workflows
- `workflow_call`
- Caller workflows
- Inputs and secrets
- Reusable workflow outputs
- Composite actions
- Difference between reusable workflows and composite actions

---

## File Included

```text
day46-reusable-workflows-composite-actions-25-mcqs.html
```

---

## What This HTML Test Contains

This MCQ file includes:

| Feature | Description |
|---|---|
| Total Questions | 25 MCQs |
| Timer | 25-minute countdown timer |
| Submit Button | Submit answers after completing the test |
| Score Result | Shows total score and percentage |
| Correct Answers | Highlights the correct answer |
| Wrong Answers | Highlights incorrect selected answers |
| Explanations | Provides explanation for every question |
| Topic Coverage | Day 46 GitHub Actions concepts |

---

## Topics Covered

The questions cover:

1. What reusable workflows are
2. What `workflow_call` does
3. Where reusable workflows must live
4. How caller workflows call reusable workflows
5. How inputs are passed
6. How secrets are passed safely
7. How outputs work in reusable workflows
8. How to use `$GITHUB_OUTPUT`
9. What composite actions are
10. How `action.yml` works
11. Where composite actions live
12. Difference between reusable workflows and composite actions

---

## How to Use This MCQ Test

### Step 1: Download the HTML File

Download this file:

```text
day46-reusable-workflows-composite-actions-25-mcqs.html
```

---

### Step 2: Open the File

You can open the HTML file in any browser:

- Google Chrome
- Microsoft Edge
- Firefox
- Safari

Right-click the file and select:

```text
Open with → Browser
```

Or double-click the file.

---

### Step 3: Start the Test

Once the file opens in the browser:

1. Read the instructions.
2. Start answering the MCQs.
3. Select one option for each question.
4. Watch the timer at the top.

---

### Step 4: Submit the Test

After answering the questions, click:

```text
Submit Test
```

The page will show:

- Your score
- Your percentage
- Correct answers
- Incorrect answers
- Explanation for every question

---

## Passing Recommendation

Use this scoring guideline:

| Score | Meaning |
|---|---|
| 80% or above | Excellent understanding |
| 60% – 79% | Good, but review weak areas |
| Below 60% | Review Day 46 notes and try again |

---

## Suggested Study Flow

Before taking the test, review:

```text
day-46-reusable-workflows.md
```

Then take the MCQ test.

Recommended flow:

```text
Read notes
Practice YAML
Run workflows
Take MCQ test
Review wrong answers
Retake test
```

---

## Day 46 Key Reminder

Simple memory trick:

```text
Reusable Workflow = reusable full workflow
Composite Action = reusable group of steps
```

Another way:

```text
Reusable Workflow = jobs level
Composite Action = steps level
```

---

## Important Difference

| Topic | Reusable Workflow | Composite Action |
|---|---|---|
| Used where? | At the `jobs` level | Inside `steps` |
| Main keyword | `on: workflow_call` | `runs: using: "composite"` |
| Can contain jobs? | Yes | No |
| Can contain multiple steps? | Yes | Yes |
| Best for | Reusing full CI/CD workflows | Reusing repeated steps |

---

## Repository Placement

Recommended location:

```text
2026/day-46/
├── day-46-reusable-workflows.md
├── day46-reusable-workflows-composite-actions-25-mcqs.html
└── README.md
```

---

## Git Commands

From your repository root:

```bash
mkdir -p 2026/day-46
cp day46-reusable-workflows-composite-actions-25-mcqs.html 2026/day-46/
cp README.md 2026/day-46/
git status
git add 2026/day-46/
git commit -m "Add Day 46 MCQs practice test"
git push
```

---

## Good Commit Message

```bash
git commit -m "Add Day 46 reusable workflows MCQs"
```

---

## Final Note

This test is for practice and revision.

If any answer is wrong, review the explanation carefully and go back to the Day 46 notes.

The goal is not only to get a good score, but to understand how reusable workflows and composite actions are used in real DevOps projects.
