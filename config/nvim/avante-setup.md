# Avante.nvim Setup Instructions

## Quick Setup

1. **Install plugins** (if not already done):
   ```bash
   # Open Neovim and run:
   :PlugInstall
   ```

2. **Build avante dependencies**:
   ```bash
   # In Neovim, run:
   :AvanteBuild
   ```

3. **Set up environment variables**:
   
   Add these to your `~/.zshrc` or `~/.zprofile`:
   
   ```bash
   # Avante.nvim API Keys (Scoped - Recommended)
   export AVANTE_ANTHROPIC_API_KEY="sk-ant-api03-your-key-here"
   export AVANTE_OPENAI_API_KEY="sk-your-openai-key-here"
   
   # Alternative: Global keys (if you prefer)
   # export ANTHROPIC_API_KEY="sk-ant-api03-your-key-here"
   # export OPENAI_API_KEY="sk-your-openai-key-here"
   ```

4. **Restart your terminal** to load the environment variables

5. **Test the setup**:
   ```bash
   # Open a file in Neovim and try:
   :AvanteAsk
   # Or use the keybinding:
   <leader>aa
   ```

## Key Bindings

| Binding | Action |
|---------|--------|
| `<leader>aa` | Show sidebar / Ask AI |
| `<leader>ae` | Edit selected code blocks |
| `<leader>ar` | Refresh sidebar |
| `<leader>af` | Switch sidebar focus |
| `<leader>at` | Toggle sidebar visibility |
| `<CR>` | Submit (in normal mode) |
| `<C-s>` | Submit (in insert mode) |

## Usage Examples

1. **Ask about current file**:
   ```
   :AvanteAsk Explain what this function does
   ```

2. **Reference multiple files**:
   ```
   :AvanteAsk Compare [src/utils.js] with [%] and suggest improvements
   ```
   - `[%]` refers to current file
   - `[path/to/file]` refers to specific file

3. **Edit selected code**:
   - Select code in visual mode
   - Press `<leader>ae`
   - Describe what you want to change

## Getting API Keys

### Claude (Anthropic)
1. Visit https://console.anthropic.com/
2. Create an account and go to API Keys
3. Generate a new key (starts with `sk-ant-api03-`)

### OpenAI
1. Visit https://platform.openai.com/api-keys
2. Create an account and generate a new key (starts with `sk-`)

## Troubleshooting

- If avante doesn't start, check if all plugins are installed: `:PlugStatus`
- If API calls fail, verify your environment variables: `:echo $AVANTE_ANTHROPIC_API_KEY`
- If build fails, try manual build: `cd ~/.vim/plugged/avante.nvim && make` 