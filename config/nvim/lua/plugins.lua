return {
  -- Colorschemes
  { 'gosukiwi/vim-atom-dark' },
  { 'folke/tokyonight.nvim', branch = 'main' },
  { 'everviolet/nvim', name = 'evergarden' },
  { 'lifepillar/vim-solarized8' },

  -- Core utilities
  { 'nvim-lua/plenary.nvim' },
  { 'christoomey/vim-tmux-navigator' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-obsession' },
  { 'tpope/vim-commentary' },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- File tree
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-tree/nvim-tree.lua' },

  -- UI enhancements
  { 'Yggdroot/indentLine' },
  { 'akinsho/bufferline.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'phaazon/hop.nvim' },
  { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end },
  { 'kdheepak/lazygit.nvim' },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },

  -- Python
  { 'deoplete-plugins/deoplete-jedi' },
  { 'psf/black' },

  -- Syntax / Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter',
    opts = {
      ensure_installed = { "sql", "go", "gomod", "gowork", "lua", "python", "javascript", "typescript" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  { 'christianchiarulli/nvcode-color-schemes.vim' },
  { 'tomlion/vim-solidity' },

  -- LSP & Completion
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/vim-vsnip' },

  -- Pretty / Formatting
  { 'nvim-lualine/lualine.nvim' },
  { 'mhartington/formatter.nvim' },
  { 'junegunn/vim-easy-align' },

  -- AI
  { 'github/copilot.vim' },
  { 'robitx/gp.nvim' },
  { 'stevearc/dressing.nvim' },
  { 'MunifTanjim/nui.nvim' },
  { 'HakonHarnes/img-clip.nvim' },
  { 'zbirenbaum/copilot.lua' },
  {
    'yetone/avante.nvim',
    branch = 'main',
    build = 'make',
    cmd = 'AvanteAsk',
  },
  { 'folke/snacks.nvim' },
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  -- Terminal
  { 'akinsho/toggleterm.nvim', version = '*' },

  -- DBT
  { 'PedramNavid/dbtpal' },
}
