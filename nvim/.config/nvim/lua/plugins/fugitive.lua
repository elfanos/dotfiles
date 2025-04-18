vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Git related mappings in Lua for Neovim
-- vim.keymap.set("n", "<leader>gc", ":Gcommit -v -q<CR>", { desc = "Git commit verbose/quiet" })
-- vim.keymap.set("n", "<leader>ga", ":Gcommit --amend<CR>", { desc = "Git amend last commit" })
-- vim.keymap.set("n", "<leader>gt", ":Gcommit -v -q %<CR>", { desc = "Git commit current file" })
-- vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { desc = "Git diff" })
-- vim.keymap.set("n", "<leader>ge", ":Gedit<CR>", { desc = "Git edit" })
-- vim.keymap.set("n", "<leader>gr", ":Gread<CR>", { desc = "Git read" })
-- vim.keymap.set("n", "<leader>gw", ":Gwrite<CR><CR>", { desc = "Git write" })
-- vim.keymap.set("n", "<leader>gl", ":silent! Glog<CR>", { desc = "Git log (silent)" })
-- vim.keymap.set("n", "<leader>gp", ":Ggrep ", { desc = "Git grep" })
-- vim.keymap.set("n", "<leader>gm", ":Gmove ", { desc = "Git move" })
-- vim.keymap.set("n", "<leader>gb", ":Git branch ", { desc = "Git branch" })
-- vim.keymap.set("n", "<leader>go", ":Git checkout ", { desc = "Git checkout" })
-- vim.keymap.set("n", "<leader>gps", ":Dispatch! git push<CR>", { desc = "Git push" })
-- vim.keymap.set("n", "<leader>gpl", ":Dispatch! git pull<CR>", { desc = "Git pull" })
vim.keymap.set("n", "<leader>md", ":Gdiff<CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>mo", ":Gdiffsplit origin/develop<CR>", { desc = "Git diff against origin/develop" })
return {
	"tpope/vim-fugitive",
	conifg = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
	end,
}
