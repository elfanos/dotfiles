return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"rust",
					"c",
					"lua",
          "markdown",
					"vim",
					"vimdoc",
					"query",
					"heex",
					"javascript",
					"typescript",
					"html",
          "tsx",
					"rust",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"heex",
					"javascript",
					"typescript",
					"html",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
        textobject = {enable = true}
			})
		end,
	},

	{ "windwp/nvim-ts-autotag" },
}
