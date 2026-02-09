# Dotfiles Setup

## Prerequisites

- macOS
- git
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed (`npm install -g @anthropic-ai/claude-code`)

## Quick Start

```bash
# Clone the repo
git clone git@github.com:<your-org>/dotfiles.git ~/dotfiles

# Run the symlink script
cd ~/dotfiles
./link.sh
```

This creates symlinks from your home directory into the dotfiles repo, so edits in either location stay in sync.

## What Gets Linked

| Source (dotfiles) | Target | Notes |
|---|---|---|
| `tmux.conf` | `~/.tmux.conf` | |
| `zshrc` | `~/.zshrc` | |
| `zprofile` | `~/.zprofile` | |
| `aliases` | `~/.aliases` | |
| `functions` | `~/.functions` | |
| `gitconfig` | `~/.gitconfig` | |
| `gitignore_global` | `~/.gitignore_global` | |
| `vimrc` | `~/.vimrc` | |
| `config/` | `~/.config` | ghostty, nvim, karabiner, etc. |
| `config/hammerspoon` | `~/.hammerspoon` | |

### Claude Code

| Source (dotfiles) | Target | Notes |
|---|---|---|
| `config/claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Global instructions |
| `config/claude/settings.json` | `~/.claude/settings.json` | Model, MCP servers, hooks, plugins |
| `config/claude/settings.local.json` | `~/.claude/settings.local.json` | Permission allowlist |
| `config/claude/agents/messari-dbt-modeler.md` | `~/.claude/agents/` | Custom agent definitions |

## Setting Up a New Machine

1. **Clone and link:**
   ```bash
   git clone git@github.com:<your-org>/dotfiles.git ~/dotfiles
   cd ~/dotfiles && ./link.sh
   ```

2. **Claude Code prerequisites:**
   - The `~/.claude/` directory must already exist (created on first `claude` run)
   - If it doesn't exist yet, run `claude` once first, then re-run `./link.sh`
   - MCP server binaries need to be installed separately:
     - Snowflake MCP: `uvx snowflake-labs-mcp` (needs `/opt/homebrew/bin/uvx`)
     - BigQuery MCP: `/usr/local/bin/toolbox` (install via Google Cloud toolbox)
   - Snowflake connection config at `~/.mcp/configuration.yaml` is not tracked (contains credentials)

3. **Keeping in sync:**
   ```bash
   cd ~/dotfiles && git pull
   ```
   Symlinks mean changes take effect immediately — no need to re-run `link.sh` unless new files were added.

## Adding New Claude Code Configs

1. Copy the file into `config/claude/`
2. Create a symlink in `link.sh`
3. Run `./link.sh` on both machines after pulling
