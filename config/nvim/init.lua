function toggle_terminal()
    print("Toggle terminal function called")  -- Debug print
    local term_bufnr = vim.fn.bufnr('term://*')
    print("Terminal buffer number:", term_bufnr)  -- Debug print
    if term_bufnr ~= -1 then
        local term_window = vim.fn.win_findbuf(term_bufnr)[1]
        print("Terminal window:", term_window)  -- Debug print
        if term_window then
            vim.api.nvim_win_close(term_window, true)
        else
            vim.cmd('split | buffer ' .. term_bufnr)
        end
    else
        vim.cmd('split | terminal')
    end
end

vim.api.nvim_set_keymap('n', '<C-b>', ':lua toggle_terminal()<CR>', {noremap = true, silent = false})
vim.api.nvim_set_keymap('t', '<C-b>', '<C-\\><C-n>:lua toggle_terminal()<CR>', {noremap = true, silent = false})

-- Set runtimepath
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")

-- Set packpath
vim.opt.packpath:prepend("~/.vim")
vim.opt.packpath:append("~/.vim/after")

-- Source .vimrc
vim.cmd('source ~/.vimrc')

-- Require other Lua modules
require('lsp_config')
require('hop_config')
require('formatter_config')
require('telescope_config')
require('treesitter')
require('status_line')
require('highlight')
require('dbtpal')
require('nvim_tree')
require('keymaps')
-- require('avante')  -- Commented out as in the original init.vim
