# Switching GitHub Remote from HTTPS to SSH

## Why Switch to SSH?

Using SSH with GitHub provides:

- No repeated password/token prompts
- More secure authentication
- Better DevOps workflow
- Easier automation
- Professional Git setup

---

# Step 1 — Check Existing SSH Keys

Run:

```powershell
ls ~/.ssh
```

Look for files like:

```text
id_ed25519
id_ed25519.pub
```

---

# Step 2 — Create SSH Key (If Needed)

If no SSH key exists:

```powershell
ssh-keygen -t ed25519 -C "your-email@example.com"
```

Example:

```powershell
ssh-keygen -t ed25519 -C "krmaryum@yahoo.com"
```

Press Enter for default options.

---

# Step 3 — Start SSH Agent

Run:

```powershell
Start-Service ssh-agent
```

---

# Step 4 — Add SSH Key to Agent

PowerShell sometimes does not expand `~` correctly.

Use:

```powershell
ssh-add $HOME\.ssh\id_ed25519
```

Expected output:

```text
Identity added
```

---

# Step 5 — Copy Public Key

Run:

```powershell
cat $HOME\.ssh\id_ed25519.pub
```

Copy the entire output.

---

# Step 6 — Add SSH Key to GitHub

Open:

https://github.com/settings/keys

Then:

1. Click **New SSH Key**
2. Add a title
3. Paste public key
4. Save

If GitHub says:

```text
Key is already in use
```

that means the key already exists on your account.

---

# Step 7 — Test SSH Authentication

Run:

```powershell
ssh -T git@github.com
```

Expected output:

```text
Hi USERNAME! You've successfully authenticated
```

Example:

```text
Hi krmaryum! You've successfully authenticated
```

---

# Step 8 — Check Current Remote URL

Run:

```powershell
git remote -v
```

HTTPS example:

```text
origin  https://github.com/USERNAME/REPO.git (fetch)
origin  https://github.com/USERNAME/REPO.git (push)
```

---

# Step 9 — Switch Remote from HTTPS to SSH

Run:

```powershell
git remote set-url origin git@github.com:USERNAME/REPO.git
```

Example:

```powershell
git remote set-url origin git@github.com:krmaryum/90DaysOfDevOps.git
```

---

# Step 10 — Verify SSH Remote

Run:

```powershell
git remote -v
```

Expected output:

```text
origin  git@github.com:USERNAME/REPO.git (fetch)
origin  git@github.com:USERNAME/REPO.git (push)
```

---

# Step 11 — Test Git Pull

Run:

```powershell
git pull
```

Expected output:

```text
Already up to date.
```

This confirms:
- SSH works
- Remote is configured correctly
- GitHub authentication is successful

---

# Final Git Workflow

```powershell
git pull
git add .
git commit -m "your commit message"
git push
```

---

# Useful SSH Commands

## Check remote

```powershell
git remote -v
```

## Test SSH

```powershell
ssh -T git@github.com
```

## Add SSH key

```powershell
ssh-add $HOME\.ssh\id_ed25519
```

## Show public key

```powershell
cat $HOME\.ssh\id_ed25519.pub
```

---

# Benefits of SSH

✅ No password prompts  
✅ More secure  
✅ Better for automation  
✅ Cleaner Git workflow  
✅ Standard professional setup
