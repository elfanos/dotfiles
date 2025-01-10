vim.keymap.set("n","<Space-l>",function ()
    vim.cmd("wincmd l")
end)

vim.keymap.set("n","<Space-h>",function ()
    vim.cmd("wincmd h")
end)

vim.keymap.set("n","<Space-j>",function ()
    vim.cmd("wincmd j")
end)

vim.keymap.set("n","<Space-k>",function ()
    vim.cmd("wincmd k")
end)
vim.keymap.set("n","<leader>x", function ()
    vim.cmd("quit")
end)

-- Map <Tab> to jump to the next buffer
vim.api.nvim_set_keymap('n', '<leader><Tab>', ':bnext<CR>', { noremap = true, silent = true })
-- Map <S-Tab> to jump to the previous buffer
vim.api.nvim_set_keymap('n', '<leader><Tab>', ':bprevious<CR>', { noremap = true, silent = true })



