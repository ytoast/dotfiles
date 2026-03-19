# Cleanup Git Worktrees

Check all worktrees in the current repo's `.worktrees/` directory and clean up any whose branches have been merged to master.

## Steps

1. Run `git worktree list` to find all worktrees
2. Run `git fetch origin master` to ensure we have the latest
3. For each worktree in `.worktrees/`:
   - Get the branch name from the worktree
   - Check if the branch has been merged to `origin/master` using `git branch --merged origin/master`
   - Also check if a PR for the branch was merged on GitHub using `gh pr list --head <branch> --state merged` (if `gh` is available)

4. **If merged to master**: Report it and remove the worktree + local branch without asking
5. **If NOT clearly merged**: Show the branch name, last commit, and how far ahead/behind master it is — then ask the user whether to delete or keep it

## Cleanup commands

```bash
# Remove worktree
git worktree remove .worktrees/<name>

# Delete local branch
git branch -d <branch-name>
```

Always show a summary at the end of what was deleted and what was kept.
