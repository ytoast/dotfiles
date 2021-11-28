local format = require('formatter')

format.setup({
  filetype = {
    python = {
      function()
        return {
          exe = 'black',
          args = { '-' },
          stdin = true,
        }
      end
    },
    terraform = {
      function()
        return {
          exe = "terraform",
          args = { "fmt", "-" },
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
  }
})

-- vim.api.nvim_set_keymap('n', '<leader>f', ":Format<CR>", {silent=true, noremap=true})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.tf,*.lua FormatWrite
augroup END
]], true)
