vim.keymap.set("n", "<leader>pv", vim.cmd.ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopWithMe()
end)

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- toggle between previous and current file in buffer, (alternat-file) 
vim.keymap.set("n", "<C-t>", "<C-^>")

-- My custom keymap

vim.keymap.set("i", "<c-u>", "<esc>bvwUi")

vim.keymap.set("n", "<leader>w", vim.cmd.w)

-- Set space b to open Buffers
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
-- Set ctrl f to open Files
vim.keymap.set("n", "<C-f>", ":Files<CR>")
-- Set space rg to open :RG!
vim.keymap.set("n", "<leader>rg", ":RG!<CR>")

-- Set relative path to clipboard with using <leader>rp
vim.keymap.set("n", "<leader>rp", ":let @+ = expand('%:p')<CR>")

vim.api.nvim_create_user_command("Rg", function(opts)
	local args = table.concat(opts.fargs, " ")
	local cmd = "rg --column --line-number --no-heading --color=always --smart-case " .. args
	vim.fn["fzf#vim#grep"](cmd, 1, vim.fn["getbufvar"]("%", "bang", 0))
end, { bang = true, nargs = "*" })

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
vim.api.nvim_set_keymap("n", "<leader>gs", ":lua fugitive_toggle()<CR>", { noremap = true, silent = true })

for key in string.gmatch("asdgh", ".") do
	vim.api.nvim_set_keymap("n", "<leader>n" .. key, "`" .. key, { noremap = true, silent = true })
end
-- ## Explanation:
--   - `vim.cmd` allows you to execute Vimscript commands in Lua.
--   - `cabbrev W w` creates a command-line abbreviation, so when you type `:W`, it will be replaced with `:w` (the write command).
-- Add this to your remap.lua file
vim.cmd([[cabbrev W w]])

-- Same for the Q should be remapped to -> q  so it quits
vim.cmd([[cabbrev Q q]])
