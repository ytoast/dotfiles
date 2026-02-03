# Global Claude Instructions

## Context7 Usage

Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.

When working with any libraries, frameworks, or APIs:
- Automatically fetch the latest documentation using context7
- Use context7 for setup and configuration instructions
- Reference context7 for code examples and best practices

## Git Worktree Best Practices

When creating git worktrees, use a `.worktrees/` subdirectory within the repo to keep them organized:

```bash
# Create a worktree
cd ~/github/org/repo
git worktree add .worktrees/feature-branch feature-branch

# Example structure
~/github/messari/dagster/                    # main checkout
~/github/messari/dagster/.worktrees/         # worktrees folder
~/github/messari/dagster/.worktrees/nex-36/  # feature worktree
```

Benefits:
- Keeps worktrees contained within the repo folder
- Doesn't pollute the org directory with worktree siblings
- Easy to find all worktrees for a repo
- Works well with the `~/github/org/repo` directory structure

## General Preferences

<!-- Add any other global preferences here -->
