local action_state = require("telescope.actions.state")
local custom_selection_ns = vim.api.nvim_create_namespace("telescope_custom_selection")

-- Define an "ugly" highlight so it's very obvious
-- (Feel free to tweak colors or use :hi UglyLine in your vimrc/init.lua)
vim.cmd([[
  " A less 'ugly' highlight with a Nord-inspired theme
  highlight UglyLine gui=bold guifg=#ECEFF4 guibg=#3B4252 cterm=bold ctermfg=15 ctermbg=8
]])

return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>sw", builtin.live_grep, { desc = "[S]earch [W]ord" })
			vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]umplist" })
			vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "[S]earch [Q]uickfix" })

			-- vim.keymap.set("n", "<leader>sb", builtin.treesitter, { desc = "Go to Symbol (Treesitter)" })
			vim.keymap.set(
				"n",
				"<leader>sb",
				require("telescope.builtin").treesitter,
				{ desc = "Go to Symbol (Treesitter)" }
			)

			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

			vim.keymap.set("n", "<leader>fw", function()
				local word = vim.fn.expand("<cword>")
				builtin.live_grep({ default_text = word })
			end)
			vim.keymap.set("n", "<leader>j", function()
				local original_buf = vim.api.nvim_get_current_buf()

				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
					previewer = true,
					attach_mappings = function(prompt_bufnr, map)
						-- My own custom ma that should make bookmark possible in bff --
						map("i", "<C-a>", function()
							local entry = action_state.get_selected_entry()
							local picker = action_state.get_current_picker(prompt_bufnr)
							local results_bufnr = picker.results_bufnr
							local row_in_results = picker:get_selection_row()
							vim.api.nvim_buf_set_mark(original_buf, "a", entry.lnum, 0, {})
							vim.api.nvim_buf_add_highlight(
								results_bufnr,
								custom_selection_ns,
								"UglyLine",
								row_in_results,
								0,
								-1
							)
						end)
						return true
					end,
				}))
			end, { desc = "[/] Fuzzily search in current buffer", silent = false })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
