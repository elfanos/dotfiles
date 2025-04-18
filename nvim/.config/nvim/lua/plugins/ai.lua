return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"Kurama622/llm.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
		config = function()
			local tools = require("llm.tools")
			require("llm").setup({
				-- [[ Github Models ]]
				url = "https://models.inference.ai.azure.com/chat/completions",
				model = "gpt-4o",
				api_type = "openai",
				max_tokens = 8000,
				temperature = 0.3,
				top_p = 0.7,

				prompt = "You are a helpful Enlgish assistant that codes alot.",

				spinner = {
					text = {
						"󰧞󰧞",
						"󰧞󰧞",
						"󰧞󰧞",
						"󰧞󰧞",
					},
					hl = "Title",
				},

				prefix = {
					user = { text = "😃 ", hl = "Title" },
					assistant = { text = "  ", hl = "Added" },
				},

				-- history_path = "/tmp/llm-history",
				save_session = true,
				max_history = 15,
				max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },
        },

				-- display diff [require by action_handler]
				display = {
					diff = {
						layout = "vertical", -- vertical|horizontal split for default provider
						opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
						provider = "mini_diff", -- default|mini_diff
					},
				},
				app_handler = {
					-- Your AI tools Configuration
					-- TOOL_NAME = { ... }
					Ask = {
						handler = tools.disposable_ask_handler,
						opts = {
							position = {
								row = 2,
								col = 0,
							},
							title = " Ask ",
							inline_assistant = true,
							language = "English",

							-- [optinal] set your llm model
							url = "https://api.chatanywhere.tech/v1/chat/completions",
							model = "gpt-4o-mini",
							api_type = "openai",
							fetch_key = function()
								return vim.env.CHAT_ANYWHERE_KEY
							end,

							-- display diff
							display = {
								mapping = {
									mode = "n",
									keys = { "d" },
								},
								action = nil,
							},
							-- accept diff
							accept = {
								mapping = {
									mode = "n",
									keys = { "Y", "y" },
								},
								action = nil,
							},
							-- reject diff
							reject = {
								mapping = {
									mode = "n",
									keys = { "N", "n" },
								},
								action = nil,
							},
							-- close diff
							close = {
								mapping = {
									mode = "n",
									keys = { "<esc>" },
								},
								action = nil,
							},
						},
					},
				},
			})
		end,
		keys = {
			{ "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
			-- Your AI Tools Key mappings
			{ "<leader>as", mode = "x", "<cmd>LLMAppHandler Ask<cr>" },
			--    |                 |                             |
			-- your key mapping  your mode                    tool name
		},
	},
}
