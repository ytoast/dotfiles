# Dotfiles

Personal dotfiles for macOS development environment.

## Structure

```
dotfiles/
├── config/nvim/          # Neovim configuration (pure Lua)
│   ├── init.lua          # Entry point
│   └── lua/
│       ├── plugins.lua   # Plugin specs (lazy.nvim)
│       ├── options.lua   # Settings, keymaps, autocmds
│       ├── lsp_config.lua
│       └── ...
├── config/gh/            # GitHub CLI config
├── config/claude-code/   # Claude Code MCP servers
├── aliases               # Shell aliases
├── functions             # Shell functions
├── zshrc                 # Zsh configuration
├── tmux.conf             # Tmux configuration
├── gitconfig             # Git configuration
└── alacritty.toml        # Terminal emulator config
```

## Neovim

- **Plugin manager:** lazy.nvim
- **Leader key:** Space
- **LSP:** pyright (Python), gopls (Go), eslint (JS/TS)
- **Colorscheme:** evergarden

### Key plugins
- telescope.nvim (fuzzy finder)
- nvim-treesitter (syntax)
- nvim-cmp (completion)
- claudecode.nvim (Claude Code integration)
- lazygit.nvim
- hop.nvim (motion)

### Common keymaps
- `<C-s>` - Save
- `<Tab>/<S-Tab>` - Next/prev buffer
- `<leader>bq` - Close buffer
- `<leader>gg` - LazyGit
- `<leader>vi` - Edit init.lua
- `gd` - Go to definition
- `gr` - References
- `K` - Hover docs

### Claude Code keymaps (`<leader>a` prefix)
- `<leader>a` - Toggle Claude Code terminal
- `<leader>aa` - Toggle Claude Code terminal
- `<leader>ab` - Open new chat
- `<leader>aC` - Open Claude Code
- `<leader>ac` - Continue conversation
- `<leader>ad` - Diff accept
- `<leader>af` - Add current file to context
- `<leader>am` - Select model
- `<leader>ar` - Diff deny (reject)
- `<leader>as` - Send selection to Claude (normal + visual)

## Shell

- **Shell:** Zsh
- **Aliases:** Defined in `aliases`
- **Functions:** Defined in `functions`

## Setup

Run `./link.sh` to symlink dotfiles to home directory.
