vim.keymap.set("n", "<leader>pv", vim.cmd.ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n","J", "mzJ`z")
vim.keymap.set("n","<C-d>","<C-d>zz")
vim.keymap.set("n","<C-u>","<C-u>zz")
vim.keymap.set("n","N","Nzzzv")

vim.keymap.set("n","<leader>vwm",function ()
   require("vim-with-me").StartWithMe()
end)
vim.keymap.set("n","<leader>svwm",function ()
   require("vim-with-me").StopWithMe()
end)

vim.keymap.set("x","<leader>p","\"_dP")


vim.keymap.set("n","<leader>y","\"+y")
vim.keymap.set("v","<leader>y","\"+y")
vim.keymap.set("n","<leader>y","\"+Y")

vim.keymap.set("n","<leader>d","\"_d")
vim.keymap.set("v","<leader>d","\"_d")

vim.keymap.set("n","<leader>f",function ()
    vim.lsp.buf.format()
end)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n","<leader>x","<cmd>!chmod +x %<CR>", { silent = true})


-- My custom keymap

vim.keymap.set("i", "<c-u>","<esc>bvwUi")

vim.keymap.set("n", "<leader>w",vim.cmd.w)


local save_and_exit_insert_mode = function()
  -- Save the current file
  vim.cmd('write')
  -- Exit insert mode and return to normal mode
  vim.cmd('stopinsert')
end

-- Set space b to open Buffers 
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
-- Set ctrl f to open Files 
vim.keymap.set("n", "<C-f>", ":Files<CR>")
-- Set space rg to open :RG! 
vim.keymap.set("n", "<leader>rg", ":RG!<CR>")

-- Set relative path to clipboard with using <leader>rp 
vim.keymap.set("n", "<leader>rp", ":let @+ = expand('%:p')<CR>")

vim.api.nvim_create_user_command('Rg', function(opts)
  local args = table.concat(opts.fargs, " ")
  local cmd = "rg --column --line-number --no-heading --color=always --smart-case " .. args
  vim.fn['fzf#vim#grep'](cmd, 1, vim.fn['getbufvar']('%', 'bang', 0))
end, {bang = true, nargs = '*'})

-- Function to toggle Fugitive
local function fugitive_toggle()
    -- Try to close Fugitive window if it's open
    local wininfo = vim.fn.getwininfo()
    for _, win in ipairs(wininfo) do
        if win.variables and win.variables.fugitive_status then
            vim.cmd(win.winnr .. "wincmd c")
            return
        end
    end
    -- If not found, run :Git
    vim.cmd("Git")
end
-- Make the function global so it can be called from the key mapping
_G.fugitive_toggle = fugitive_toggle
-- Map <leader>gs to call the FugitiveToggle function
vim.api.nvim_set_keymap('n', '<leader>gs', ':lua fugitive_toggle()<CR>', { noremap = true, silent = true })

vim.keymap.set("n","<leader>fw", function ()
    local word = vim.fn.expand("<cword>")
    vim.cmd(":RG \\<" .. word .. "\\>")
end)

