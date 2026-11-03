"# SELinux Context & Confined vs Unconfined MCQ Quiz

## Overview
This repository contains an interactive HTML quiz for practicing **SELinux Context** and **Confined vs Unconfined** concepts.

### Features
- 25 MCQs
- 30-minute timer
- Automatic scoring
- Pass/Fail result
- Correct answer highlighting
- Detailed explanations
- Progress counter
- Retake quiz

## Included File

`selinux-context-confined-25-mcqs-timer.html`

## How to Use

### 1. Download
Download the HTML quiz file.

### 2. Open
**Windows:** Double-click the file or open it in Chrome, Edge, or Firefox.

**Linux**
```bash
firefox selinux-context-confined-25-mcqs-timer.html
```
or
```bash
google-chrome selinux-context-confined-25-mcqs-timer.html
```

**macOS:** Open with Safari, Chrome, or Firefox.

### 3. Start the Test
1. Read each question carefully.
2. Select one answer.
3. Complete all 25 questions.
4. Click **Submit Quiz**.

### 4. Review Results
After submission you will see:
- Score
- Percentage
- Pass/Fail
- Correct answers
- Your answers
- Explanation for every question

### 5. Practice Again
Click **Retake Quiz** to restart.

## Recommended Learning Order
1. Learn SELinux Basics
2. Learn SELinux Context
3. Learn Confined vs Unconfined
4. Practice commands
5. Complete the quiz
6. Review explanations
7. Repeat until scoring 80%+

## Important Commands
```bash
getenforce
sestatus
ls -Z
ls -Zd /var/www/html
ps -eZ
id -Z
restorecon -Rv /var/www/html
chcon -t httpd_sys_content_t file
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
ausearch -m AVC -ts recent
```

## Quick Memory Tricks
```text
Context = Identity + Background Information
user : role : type : level
Confined = Restricted
Unconfined = Less Restricted
restorecon = Restore Default Context
chcon = Temporary Context Change
semanage fcontext = Permanent Context Rule
```

## Best For
- RHCSA EX200
- Linux Administration
- DevOps
- Interview Preparation
- Classroom Training

## Author
**Muhammad Khalid Khan**

GitHub: https://github.com/krmaryum
