# Git Study Notes: `git pull --ff-only` vs `git pull --rebase`

**Level:** Beginner → Intermediate  
**Context:** eMarkaz Course Library (production repo #1) and test-github-actions (practice repo #2)  
**Purpose:** Understand *what*, *why*, *when*, and *how* to synchronize local and remote Git branches safely.

---

## 1. Learning objectives

By the end of these notes you will be able to:

- Explain **local `main`**, **`origin/main`**, **working tree**, and **commit history**.
- Distinguish **fetch**, **pull**, **fast-forward**, **merge**, and **rebase**.
- Choose between `git pull --ff-only origin main` and `git pull --rebase origin main`.
- Diagnose a clean but out-of-date local branch.
- Handle common errors and rebase conflicts safely.
- Follow a repeatable process in production and practice repositories.

## 2. Important Git terms (What / Why)

| Term | English meaning | Roman Urdu explanation |
|---|---|---|
| Repository (repo) | A project tracked by Git. | Project ka Git record aur files. |
| Working tree | Files currently on your computer. | Aapke folder mein jo files abhi maujood hain. |
| Commit | A saved snapshot of tracked changes. | Git history mein save ki hui tabdeeli. |
| Local `main` | Your computer's `main` branch. | Laptop wali `main` branch. |
| Remote `origin` | A name for the remote repository, normally GitHub. | GitHub repository ka local shortcut naam. |
| `origin/main` | Local record of the remote `main` branch as last fetched. | GitHub `main` ki *aakhri fetched* information, zaroori nahi ke bilkul live ho. |
| Fast-forward | Advance a branch pointer without creating a new commit. | Seedha naye commit tak aagay barhna; merge commit nahi banta. |
| Diverged | Local and remote branches have different new commits. | Dono taraf alag-alag commits ban gaye. |
| Rebase | Replay local commits on top of another branch tip. | Apne local commits ko latest GitHub commits ke baad dobara apply karna. |

**Key point:** `git status` saying "up to date with 'origin/main'" compares your branch against your **last-fetched** remote-tracking reference. It does **not** contact GitHub. Use `git fetch origin` for an updated comparison.

## 3. What does `git pull` do?

In a typical setup:

```text
git pull = git fetch + integrate the fetched changes
```

Integration usually means **merge**, **rebase**, or **fast-forward-only**, depending on your command and configuration.

```bash
git fetch origin                   # Download remote information; do not change working branch
git pull --ff-only origin main     # Fetch; advance only if fast-forward is possible
git pull --rebase origin main      # Fetch; rebase your local commits if branches diverged
```

`git pull --rebase` is not always necessary. If the local branch is simply behind the remote and has no extra local commits, Git can fast-forward without replaying commits.

## 4. What is `git pull --ff-only`?

**Meaning:** Fetch and update your current branch **only when a fast-forward is possible**. If the local and remote branches have diverged, Git stops rather than making a merge commit or rewriting local commits.

### Example A — Local branch is behind (your real eMarkaz scenario)

Before GitHub website edits were pulled:

```text
A (fdb5a2e) ── B (GitHub docs commit) ── C (3a84fde)
^
local main                               ^
                                         origin/main after fetch
```

You created `docs/README.md` and `docs/eMarkaz_Repo1_Complete_Upload_Guide.md` through the GitHub website. Your laptop had not yet fetched those commits, so the local branch was behind GitHub.

Command:

```bash
cd /c/Linux/emarkaz-course-library
git status
git pull --ff-only origin main
git status
```

Your terminal showed:

```text
Updating fdb5a2e..3a84fde
Fast-forward
 docs/README.md                              |   3 +
 docs/eMarkaz_Repo1_Complete_Upload_Guide.md | 333 +
```

**Interpretation:** Git moved local `main` forward to the new commit. No merge commit was created; no local commit was rewritten.

**Roman Urdu:** GitHub par documentation add hui thi. Laptop par extra local commits nahi thay. Is liye `--ff-only` ne branch ko seedha GitHub ki latest history tak update kar diya.

### Example B — Branches diverged: `--ff-only` stops

```text
           B (local commit)
          /
A ────────
          \
           C (GitHub commit)
```

```bash
git pull --ff-only origin main
```

Possible outcome:

```text
fatal: Not possible to fast-forward, aborting.
```

This **protects you from an automatic merge/rebase**. You must decide how to integrate the divergent histories.

## 5. What is `git pull --rebase`?

**Meaning:** Fetch remote commits; when needed, put local-only commits on top of the fetched branch tip.

Before:

```text
           B (local)
          /
A ────────
          \
           C (remote)
```

After `git pull --rebase origin main`:

```text
A ── C ── B'
          ^
          new version of local commit B
```

`B'` can have a **different commit hash**, because its parent changed.

Use:

```bash
cd /c/Linux/emarkaz-course-library
git status
git pull --rebase origin main
```

**Roman Urdu:** Agar aapne laptop par ek commit banaya aur GitHub website par doosra commit aa gaya, to rebase aapka local commit GitHub wale commit ke baad apply karta hai. History seedhi nazar aati hai.

**Important caution:** Rebase generally rewrites the IDs of local commits it replays. Avoid rebasing commits already shared with others unless your team has agreed on that workflow.

## 6. Side-by-side comparison

| Question | `--ff-only` | `--rebase` |
|---|---|---|
| Downloads remote changes? | Yes | Yes |
| Works if local is only behind? | Yes — fast-forward | Yes — usually fast-forward |
| Works if local and remote diverged? | **No — stops** | **Yes — replays local commits** (unless conflicts/errors) |
| Creates a merge commit? | No | No (for normal rebase) |
| Rewrites local-only commit hashes? | No | May do so |
| Good default for simple production sync? | Yes | Depends on workflow |
| Needs conflict resolution if the same content changed? | Stops before integrating divergent histories | May pause for conflict resolution |

Neither command is "always better." The correct choice depends on whether you have local commits and whether branches have diverged.

## 7. Your eMarkaz example: interpreting the output

You ran:

```bash
git status
```

and saw:

```text
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```

Then `git pull --ff-only origin main` fetched new remote data and showed:

```text
From github.com:krmaryum/emarkaz-course-library
   fdb5a2e..3a84fde  main -> origin/main
Updating fdb5a2e..3a84fde
Fast-forward
```

This is **not a contradiction**:

1. Initially, local `origin/main` had not been refreshed after the web upload.
2. `git status` checked your local `main` against that older remote-tracking reference.
3. `git pull` fetched the actual newer GitHub commits.
4. Git advanced local `main` without conflict.
5. The final `git status` showed a clean, synchronized repository.

**Roman Urdu:** Pehle `git status` ne purani downloaded information compare ki. `git pull` ne GitHub se latest updates le kar laptop update kar diya.

## 8. Decision guide: which command to use?

### Case 1 — You edited on GitHub web and have not created new local commits

```bash
cd /c/Linux/emarkaz-course-library
git status
git pull --ff-only origin main
```

This is the normal low-risk sync for repo #1.

### Case 2 — You made local commits, but GitHub has no new commits

```bash
git status
git push origin main
```

No pull is necessary if your local branch is already based on current remote history.

### Case 3 — You made local commits **and** GitHub has new commits

```bash
git status
git fetch origin
git log --oneline --left-right main...origin/main
git pull --rebase origin main
```

The log command shows local-only commits with `<` and remote-only commits with `>` (when `main` is the left side). If the rebase succeeds, push normally:

```bash
git push origin main
```

If the commits have already been shared with other people, check with collaborators before rebasing them.

### Case 4 — You have uncommitted edits

First:

```bash
git status
```

**Do not blindly pull over uncommitted changes.** Safest beginner choices are to commit your work first or use a stash:

```bash
git stash push -u -m "Before syncing eMarkaz"
git pull --ff-only origin main
git stash pop
```

`git stash pop` can cause conflicts if changes overlap. Inspect `git status` afterwards. Untracked files are included in the stash here because of `-u`. Do not stash files that you need to exclude for privacy/security without reviewing them.

## 9. If rebase has conflicts

Example:

```bash
git pull --rebase origin main
# CONFLICT in index.html
```

Safe procedure:

```bash
git status                 # Find conflicted files
# Open the file and resolve conflict markers manually
git add index.html
git rebase --continue       # Continue replaying commits
```

If you decide not to proceed:

```bash
git rebase --abort
```

This returns to the pre-rebase branch state in ordinary cases. Never delete conflict markers without understanding which changes must be kept. Avoid `git push --force` on production `main`.

## 10. Common troubleshooting

**A. `fatal: Not possible to fast-forward, aborting.`**  
Local and remote commits have diverged. Review the graph and decide whether rebasing is appropriate:

```bash
git fetch origin
git log --oneline --graph --decorate --all -12
```

**B. `cannot pull with rebase: You have unstaged changes`**  
Commit or stash first; verify with `git status`.

**C. `CONFLICT (content)` while rebasing**  
Resolve files, `git add`, `git rebase --continue`, or use `git rebase --abort`.

**D. `Everything up-to-date` from push but the website still looks old**  
Git push and GitHub Pages deployment are different steps. Check the Actions deployment and refresh the browser after it completes. Do not alter Git history just to refresh the website.

**E. You committed a file through GitHub browser, but your laptop doesn't show it**  
From a clean working tree, use:

```bash
git pull --ff-only origin main
```

## 11. Practical lab (repo #2 only)

Use `/c/Linux/test-github-actions` for deliberate rebase practice. Do not create artificial history divergence on production `main`.

For a harmless viewing exercise:

```bash
cd /c/Linux/test-github-actions
git status
git fetch origin
git log --oneline --graph --decorate --all -10
git log --oneline --left-right main...origin/main
```

Observe whether commits differ between local and remote. If they do not diverge, a rebase will not demonstrate commit replay.

For a full divergence experiment, use two separate disposable clones/branches, not the live site's `main` branch. Make one local commit in one clone and push a different commit from the other; then fetch and rebase in the first. Clean up the practice branches afterwards.

## 12. Recommended everyday commands for repo #1

After making GitHub website changes and **before** further local edits:

```bash
cd /c/Linux/emarkaz-course-library
git status
git pull --ff-only origin main
git status
```

When adding books or homepage buttons locally:

```bash
cd /c/Linux/emarkaz-course-library
./upload.sh
```

Wait for the GitHub Pages workflow to **succeed** before expecting the new homepage to appear.

After an ordinary upload:

```bash
git status
git log --oneline --decorate -5
```

## 13. Interview questions with short answers

**Q1. What does `git pull` do?**  
Fetches remote changes, then integrates them into your current branch.

**Q2. What is a fast-forward?**  
Moving the branch pointer forward along existing history without a new merge commit.

**Q3. Why use `--ff-only`?**  
It prevents automatic history integration when branches have diverged.

**Q4. Why use rebase?**  
To replay local commits on top of newer remote commits, often for linear history.

**Q5. Does `git pull --rebase` always rewrite commits?**  
No. If the branch can simply fast-forward, it normally does not need to replay commits.

**Q6. What if rebase conflicts?**  
Resolve affected files, stage fixes and continue, or abort.

**Q7. Why did `git status` first say up-to-date but `git pull` downloaded commits?**  
Because `git status` did not contact GitHub and `origin/main` was stale.

**Q8. Do you need `git push --force` after a normal rebase of unpublished local commits?**  
No. A normal `git push origin main` should work after rebasing local-only commits onto current remote history.

## 14. Final quick-reference

```text
GitHub changed, local did not       → git pull --ff-only origin main
Local changed, GitHub did not       → git push origin main
Both created different new commits  → review, then git pull --rebase origin main
Uncommitted changes present         → commit or stash before pulling
Rebase conflict                     → resolve + git add + git rebase --continue
Cancel rebase                       → git rebase --abort
See history                         → git log --oneline --graph --decorate --all -12
```

**Remember:** `--ff-only` prioritizes *safety and stopping on divergence*. `--rebase` is for *integrating local commits after newer remote commits*. Both are useful; the context decides.

---

### Repo-specific references

- Production: `https://github.com/krmaryum/emarkaz-course-library`
- Practice: `https://github.com/krmaryum/test-github-actions`
- Production website: `https://emarkazlibrary.com`
- Suggested storage path: `docs/Git_Pull_FF_Only_vs_Rebase_Study_Notes.md`
