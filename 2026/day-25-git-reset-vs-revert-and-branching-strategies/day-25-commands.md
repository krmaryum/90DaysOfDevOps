# Day 25 Commands Summary Table

| Command | Purpose | Safe for Shared Branches? | Notes |
|---|---|---|---|
| `git reset --soft HEAD~1` | Removes latest commit but keeps changes staged | No | Useful for fixing commit messages or recommitting |
| `git reset --mixed HEAD~1` | Removes latest commit and unstages changes | No | Keeps file changes in working directory |
| `git reset --hard HEAD~1` | Removes latest commit and deletes changes | No | Destructive command |
| `git revert <commit-hash>` | Creates a new commit that undoes previous changes | Yes | Preserves Git history |
| `git revert --continue` | Continues revert after resolving conflicts | Yes | Used during revert conflict resolution |
| `git revert --abort` | Cancels current revert operation | Yes | Restores repository state before revert |
| `git reflog` | Shows history of HEAD movements | Yes | Useful for recovery after reset mistakes |

---

# Reset vs Revert Comparison

| Feature | `git reset` | `git revert` |
|---|---|---|
| Removes commits from visible history | Yes | No |
| Rewrites Git history | Yes | No |
| Creates a new commit | No | Yes |
| Safe for pushed/shared branches | Usually No | Yes |
| Best use case | Local cleanup before push | Undoing pushed commits safely |
| Can be destructive | Yes (`--hard`) | No |

---

# Branching Strategies Summary

| Strategy | How it works | Best Used For | Pros | Cons |
|---|---|---|---|---|
| GitFlow | Uses `main`, `develop`, feature, release, and hotfix branches | Large teams with scheduled releases | Organized workflow and release management | More complex |
| GitHub Flow | Uses one `main` branch with short-lived feature branches | Startups and fast deployments | Simple and fast | Less structured |
| Trunk-Based Development | Developers frequently merge small changes into `main` | CI/CD and DevOps teams | Fast integration and fewer merge conflicts | Requires strong testing |