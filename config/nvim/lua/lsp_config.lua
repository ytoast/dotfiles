-- General settings
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Required modules
local lsp = require('lspconfig')
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- LSP functions
local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

-- Custom LSP attach function
local function custom_attach(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- LSP keymappings
  local keymap_set = function(mode, lhs, rhs, extra_opts)
    local opts = vim.tbl_extend("force", bufopts, extra_opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  keymap_set('n', 'gD', vim.lsp.buf.declaration)
  keymap_set('n', 'gd', vim.lsp.buf.definition)
  keymap_set('n', 'K', vim.lsp.buf.hover)
  keymap_set('n', 'gi', vim.lsp.buf.implementation)
  keymap_set('n', '<C-k>', vim.lsp.buf.signature_help)
  keymap_set('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
  keymap_set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
  keymap_set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
  keymap_set('n', '<space>D', vim.lsp.buf.type_definition)
  keymap_set('n', '<space>rn', vim.lsp.buf.rename)
  keymap_set('n', '<space>ca', vim.lsp.buf.code_action)
  keymap_set('n', 'gr', vim.lsp.buf.references)
  keymap_set('n', '<space>f', '<cmd>Format<cr>')
end

-- CMP setup
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
}

-- Filetype-specific configurations
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

-- Cmdline configurations
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {{ name = 'buffer' }}
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- LSP capabilities
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Utility function
local function read_exec_path(exec_name)
    local handle = io.popen("which " .. exec_name)
    local result = handle:read("*a"):gsub("\n", "")
    handle:close()
    return result
end

-- LSP setups
lsp.eslint.setup {
  capabilities = capabilities
}

lsp.pyright.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
  settings = {
    python = {
      pythonPath = read_exec_path("python"),
    },
  },
}
