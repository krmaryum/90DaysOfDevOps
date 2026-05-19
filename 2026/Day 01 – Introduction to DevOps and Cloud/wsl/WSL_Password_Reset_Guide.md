# Reset Forgotten Password in WSL

## Method 1 — Reset Password from Root User

### Step 1: Open PowerShell as Administrator

Search for **PowerShell** → Right-click → **Run as Administrator**

---

### Step 2: Start WSL as root

Replace `Ubuntu` with your distro name if different.

```powershell
wsl -d Ubuntu -u root
```

To list installed distros:

```powershell
wsl -l -v
```

---

### Step 3: Reset your password

Inside WSL:

```bash
passwd your_username
```

Example:

```bash
passwd khalid
```

Enter the new password twice.

---

### Step 4: Exit and restart WSL

```bash
exit
```

Then open WSL normally and log in with the new password.

---

# If You Forgot Your Username

Inside root shell run:

```bash
ls /home
```

That shows available usernames.

---

# Optional: Make Your User Default Again

```powershell
ubuntu config --default-user your_username
```

Or:

```powershell
wsl -d Ubuntu -u your_username
```

---

# If `passwd` Says Authentication Token Error

```bash
mount -o remount,rw /
passwd your_username
```

---

# Last Resort (Reset Distro)

⚠️ Warning: This deletes Linux files/settings.

```powershell
wsl --unregister Ubuntu
```

Then reinstall from Microsoft Store.
