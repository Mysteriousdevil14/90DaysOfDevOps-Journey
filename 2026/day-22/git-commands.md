# Git Commands Cheat Sheet

A practical Git reference for daily development work.

## 1. Configure Git (one-time setup)

Set the name and email that will appear on your commits:

``` bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Check your configuration:

``` bash
git config --global --list
git config user.name
git config user.email
```

> Use the email associated with your Git hosting account if you want
> commits to be attributed to that account.

## 2. Start or get a repository

Initialize Git in the current directory:

``` bash
git init
```

Clone an existing repository:

``` bash
git clone https://github.com/username/repository.git
```

Show the repository's root directory:

``` bash
git rev-parse --show-toplevel
```

## 3. Check repository status

``` bash
git status
git status --short
```

`git status` shows changed, staged, and untracked files. Run it often.

## 4. Stage and commit changes

Stage one file:

``` bash
git add filename
```

Stage all changes in the current repository:

``` bash
git add .
```

Review what is staged:

``` bash
git diff --staged
```

Commit staged changes:

``` bash
git commit -m "Add log analyzer script"
```

Stage and commit tracked-file changes in one step (does not include new
untracked files):

``` bash
git commit -am "Update documentation"
```

## 5. View changes

Show unstaged changes:

``` bash
git diff
```

Show staged changes:

``` bash
git diff --staged
```

Compare two commits:

``` bash
git diff commit1 commit2
```

Show a summary of changed files:

``` bash
git diff --stat
```

## 6. View commit history

Compact history:

``` bash
git log --oneline
```

Show history as a graph:

``` bash
git log --oneline --graph --decorate --all
```

Show the latest commit:

``` bash
git log -1
```

Show details of a commit:

``` bash
git show <commit-hash>
```

> Correct spelling: `--oneline` (not `--onelin`).

## 7. Branch commands

List local branches:

``` bash
git branch
```

Create a branch:

``` bash
git branch feature-name
```

Switch to a branch:

``` bash
git switch feature-name
```

Create and switch to a new branch:

``` bash
git switch -c feature-name
```

Merge a branch into the current branch:

``` bash
git merge feature-name
```

Delete a merged local branch:

``` bash
git branch -d feature-name
```

## 8. Connect to a remote repository

List remotes:

``` bash
git remote -v
```

Add a remote named `origin`:

``` bash
git remote add origin https://github.com/username/repository.git
```

Change the URL of `origin`:

``` bash
git remote set-url origin https://github.com/username/repository.git
```

Push the current branch and set its upstream:

``` bash
git push -u origin <branch-name>
```

Push later commits:

``` bash
git push
```

Fetch remote changes without merging:

``` bash
git fetch
```

Pull changes from the remote branch:

``` bash
git pull
```

## 9. Undo and restore carefully

Unstage a file while keeping its changes:

``` bash
git restore --staged filename
```

Discard unstaged changes in a file:

``` bash
git restore filename
```

Create a new commit that reverses an earlier commit:

``` bash
git revert <commit-hash>
```

Move the current branch back one commit but keep changes staged:

``` bash
git reset --soft HEAD~1
```

Move the current branch back one commit and keep changes unstaged:

``` bash
git reset --mixed HEAD~1
```

Discard local changes and move the current branch to a commit:

``` bash
git reset --hard <commit-hash>
```

**Warning:** `git reset --hard` permanently discards uncommitted changes
in tracked files. Make sure you understand what will be lost before
running it. Prefer `git revert` when undoing a commit that has already
been shared with others.

## 10. Add files Git should ignore

Create or edit `.gitignore`:

``` gitignore
.env
node_modules/
*.log
.DS_Store
```

Check whether a file is ignored:

``` bash
git check-ignore -v filename
```

## 11. A common daily workflow

``` bash
git status
git add .
git status
git diff --staged
git commit -m "Describe your changes"
git push
```

## 12. Quick command reference

  Command                     Purpose
  --------------------------- -----------------------------------------
  `git init`                  Initialize a repository
  `git clone URL`             Copy a remote repository locally
  `git status`                Check working-tree status
  `git add .`                 Stage changes
  `git commit -m "message"`   Save a commit
  `git log --oneline`         View compact history
  `git diff`                  View unstaged changes
  `git diff --staged`         View staged changes
  `git branch`                List branches
  `git switch -c name`        Create and switch branch
  `git remote -v`             List remote URLs
  `git pull`                  Fetch and integrate remote changes
  `git push`                  Send commits to a remote
  `git revert HASH`           Undo a commit with a new commit
  `git reset --hard HASH`     Reset and discard tracked local changes

## Important reminders

-   Git commands should be run inside the intended repository.
-   `git add` stages changes; `git commit` records staged changes.
-   A commit is local until you push it to a remote.
-   Check `git status` before committing or undoing anything.
-   Be especially careful with `git reset --hard`, `git clean`, and
    force-push commands.
