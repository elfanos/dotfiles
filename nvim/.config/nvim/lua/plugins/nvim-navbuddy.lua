return {
  -- # TODO need to integragte somehow with nvim-navic? 
  --  also it fails on set keymap, see docs (https://github.com/SmiteshP/nvim-navbuddy)
  --  nvim-navic docs (https://github.com/SmiteshP/nvim-navic)
	{
		-- "SmiteshP/nvim-navbuddy",
		-- cmd = "Navbuddy",
		-- dependencies = {
		-- 	"SmiteshP/nvim-navic",
		-- 	"MunifTanjim/nui.nvim",
		-- },
		-- config = function()
		-- 	require("nvim-navbuddy").setup({
		--
		-- 		window = {
		-- 			border = "rounded",
		-- 		},
		-- 		icons = require("nvim-web-devicons").get_icons().kind,
		-- 		lsp = { auto_attach = true },
		-- 	})
		--
		-- 	local opts = { noremap = true, silent = true }
		-- 	vim.set.keymap("n", "<leader>j", ":Navbuddy <cr>", opts)
		-- end,
	},
}
