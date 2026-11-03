# How to Use These Quizzes

## Step 1: Download the Quiz Files

Download the following HTML files:

* `linux-suid-sgid-sticky-bit-acl-25-mcqs-timer.html`
* `linux-special-permissions-scenario-based-mcqs.html`

---

## Step 2: Open the Quiz

After downloading:

### Windows

* Locate the downloaded `.html` file.
* Double-click the file.
* It will automatically open in your default web browser.

### Linux

Open from the file manager or run:

```bash
firefox linux-suid-sgid-sticky-bit-acl-25-mcqs-timer.html
```

or

```bash
google-chrome linux-suid-sgid-sticky-bit-acl-25-mcqs-timer.html
```

### macOS

Double-click the file or open it using Safari, Chrome, or Firefox.

---

## Step 3: Start the Test

* Read each question carefully.
* Select the best answer.
* Complete all questions before the timer expires.
* Click **Submit Quiz**.

---

## Step 4: Review Your Results

After submission, the quiz will display:

* Your score
* Percentage
* Pass/Fail result
* Correct answers
* Your selected answers
* Detailed explanations

---

## Step 5: Retake the Quiz

Click the **Retake Quiz** button to restart the test and practice again.

---

## Recommended Learning Order

1. Read the study notes.
2. Complete the 25-question MCQ quiz.
3. Review explanations.
4. Complete the scenario-based quiz.
5. Repeat until you consistently score 80% or higher.

---

## Goal

These quizzes are designed to help students:

* Understand SUID
* Understand SGID
* Understand Sticky Bit
* Understand ACLs
* Prepare for RHCSA
* Prepare for Linux Administration interviews
* Build confidence through practice




---

# Linux Special Permissions Quiz Collection

## Overview

This repository contains interactive HTML quizzes for learning and practicing:

- SUID (Set User ID)
- SGID (Set Group ID)
- Sticky Bit
- ACL (Access Control Lists)

These quizzes are useful for:

- RHCSA Preparation
- Linux Administration
- DevOps Learning
- Classroom Training
- Interview Preparation

---

## Files Included

### linux-suid-sgid-sticky-bit-acl-25-mcqs-timer.html

Comprehensive 25-question quiz covering:

- SUID
- SGID
- Sticky Bit
- ACL
- Commands
- Numeric values
- Symbols
- Real-world usage

Features:

- 30-minute timer
- Automatic scoring
- Pass/Fail result
- Answer explanations
- Retake option

---

### linux-special-permissions-scenario-based-mcqs.html

Scenario-based quiz focused on practical understanding.

Features:

- Real-world scenarios
- Troubleshooting questions
- Detailed explanations
- Timer
- Score calculation

---

## Recommended Learning Path

1. Learn Linux permissions
2. Study SUID
3. Study SGID
4. Study Sticky Bit
5. Study ACL
6. Complete the 25-question quiz
7. Complete the scenario-based quiz

---

## Important Commands

### SUID

```bash
chmod u+s file
chmod 4755 file
find / -perm -4000 -type f 2>/dev/null
```

### SGID

```bash
chmod g+s directory
chmod 2775 directory
```

### Sticky Bit

```bash
chmod +t directory
chmod 1777 directory
```

### ACL

```bash
getfacl file.txt
setfacl -m u:user:r file.txt
setfacl -x u:user file.txt
setfacl -b file.txt
```

---

## Quick Memory Tricks

```text
4 = SUID
2 = SGID
1 = Sticky Bit
```

```text
SUID   = Run as Owner
SGID   = Shared Group
Sticky = Protect Deletion
ACL    = Advanced Permissions
```

---

## RHCSA Exam Tips

```text
-rwsr-xr-x   = SUID
drwxrwsr-x   = SGID
drwxrwxrwt   = Sticky Bit
-rw-r--r--+  = ACL
```

Verify changes:

```bash
ls -l
ls -ld directory
getfacl file
```

---

## Author

Muhammad Khalid Khan

GitHub: https://github.com/krmaryum
