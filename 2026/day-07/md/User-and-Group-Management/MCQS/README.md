# Linux User Home Directory Recovery & Troubleshooting MCQ Quiz

## Overview

This repository contains an interactive HTML quiz based on **Linux User Management**, **Home Directory Recovery**, and **Real-world Troubleshooting**.

It is designed for:

- RHCSA (EX200) Preparation
- Linux Administration
- DevOps Engineers
- System Administrators
- Classroom Training
- Interview Preparation
- Self-Study

---

# Files Included

## 📄 linux-user-home-recovery-troubleshooting-25-mcqs-timer.html

This interactive quiz contains **25 multiple-choice questions** covering:

- User account vs Home directory
- Recovering a deleted home directory
- `/etc/skel`
- `chown` and `chmod`
- Home directory ownership
- `.hushlogin`
- `userdel` vs `userdel -r`
- `usermod`
- `pwck`
- Changing the default shell with `chsh`
- Real-world Linux troubleshooting scenarios

---

# Features

- ✅ 25 MCQs
- ✅ 30-Minute Countdown Timer
- ✅ Progress Counter
- ✅ Automatic Scoring
- ✅ Percentage Calculation
- ✅ Pass / Fail Result
- ✅ Correct Answer Highlighting
- ✅ Shows Your Selected Answer
- ✅ Detailed Explanation for Every Question
- ✅ Retake Quiz Button

---

# How to Use

## Step 1 – Download

Download:

```text
linux-user-home-recovery-troubleshooting-25-mcqs-timer.html
```

## Step 2 – Open

### Windows

Open the file by double-clicking it or with:

- Google Chrome
- Microsoft Edge
- Mozilla Firefox

### Linux

```bash
firefox linux-user-home-recovery-troubleshooting-25-mcqs-timer.html
```

or

```bash
google-chrome linux-user-home-recovery-troubleshooting-25-mcqs-timer.html
```

### macOS

Open with Safari, Chrome, or Firefox.

---

## Step 3 – Take the Quiz

1. Read each question carefully.
2. Select the best answer.
3. Complete all questions before the timer expires.
4. Click **Submit Quiz**.

---

## Step 4 – Review Results

After submission you will see:

- Score
- Percentage
- Pass / Fail status
- Correct answers
- Your selected answers
- Explanation for every question

---

## Step 5 – Practice Again

Click **Retake Quiz** to restart and improve your score.

---

# Recommended Learning Path

1. Learn Linux user management.
2. Understand home directory recovery.
3. Practice `/etc/skel`, `chown`, and `chmod`.
4. Learn `userdel`, `usermod`, and `pwck`.
5. Practice changing the login shell.
6. Complete the quiz.
7. Review explanations.
8. Repeat until you consistently score **80% or higher**.

---

# Important Commands

```bash
id username
mkdir /home/username
cp -a /etc/skel/. /home/username/
chown -R username:username /home/username
chmod 700 /home/username
userdel username
userdel -r username
usermod -d /home/newuser -m username
pwck
echo $SHELL
chsh -s /bin/bash username
touch ~/.hushlogin
```

---

# Quick Memory Tricks

```text
Deleted Home ≠ Deleted User

mkdir
↓
copy /etc/skel
↓
chown -R
↓
chmod 700
↓
Test Login
```

```text
Permission denied?
→ Check ownership

Prompt shows only $
→ Check echo $SHELL

/bin/sh
→ chsh -s /bin/bash username
```

---

# Best For

- RHCSA EX200
- Linux Administration
- DevOps Interviews
- User Management Labs
- Linux Troubleshooting
- Classroom Practice

---

# Author

**Muhammad Khalid Khan**

GitHub: https://github.com/krmaryum

---

Happy Learning and Best of Luck with your Linux Administration and RHCSA journey!
