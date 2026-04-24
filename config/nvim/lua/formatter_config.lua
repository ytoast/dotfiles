local format = require("formatter")

-- oxfmt (used in ~/github/messari/messari-web) — resolves the binary from the
-- nearest node_modules walking up from the current buffer so each worktree
-- uses its own install.
local function oxfmt()
  local bufname = vim.api.nvim_buf_get_name(0)
  local found = vim.fs.find("node_modules/.bin/oxfmt", {
    upward = true,
    path = vim.fn.fnamemodify(bufname, ":p:h"),
  })[1]
  if not found then return nil end
  return {
    exe = found,
    args = { "--stdin-filepath=" .. bufname },
    stdin = true,
  }
end

format.setup(
  {
    filetype = {
      python = {
        function()
          return {
            exe = "black",
            args = {"-"},
            stdin = true
          }
        end
      },
      terraform = {
        function()
          return {
            exe = "terraform",
            args = {"fmt", "-"},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      go = {
        function()
          return {
            exe = "gofmt",
            args = {},
            stdin = true
          }
        end
      },
      javascript = { oxfmt },
      javascriptreact = { oxfmt },
      typescript = { oxfmt },
      typescriptreact = { oxfmt },
      json = { oxfmt },
      jsonc = { oxfmt },
      css = { oxfmt },
      markdown = { oxfmt },
    }
  }
)

-- Format-on-save, scoped to the messari-web repo only.
vim.api.nvim_create_augroup("MessariWebFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "MessariWebFormatOnSave",
  pattern = {
    "*.js", "*.jsx", "*.mjs", "*.cjs",
    "*.ts", "*.tsx", "*.mts", "*.cts",
    "*.json", "*.jsonc",
    "*.css",
    "*.md",
  },
  callback = function(args)
    local path = vim.fn.fnamemodify(args.file, ":p")
    if path:match("/messari%-web/") then
      vim.cmd("FormatWrite")
    end
  end,
})

-- Removed duplicate keybinding since <space>f is now handled in LSP config
