return {
	"rebelot/heirline.nvim",
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local f_component = require("rallmo-style.file_component")
		-- Get the file components
		local file_components = f_component.setup_file_components(conditions, utils)

		-- Define the FileNameComponent
		local FileNameComponent = utils.insert(
			file_components.FileNameBlock,
			file_components.FileIcon,
			utils.insert(file_components.FileNameModifier, file_components.FileName), -- Corrected typo here
			file_components.FileFlags,
			{ provider = "%<" } -- This means that the statusline is cut here when there's not enough space
		)

		-- Define the Git component
		local Git = {
			condition = conditions.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { fg = "orange" },

			{ -- Git branch name
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			-- You could handle delimiters, icons and counts similar to Diagnostics
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "(",
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = "fg" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = "git_change" },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ")",
			},
		}

    vim.print("hello again")
		-- Define colors
		local colors = {
			bright_bg = utils.get_highlight("Folded").bg,
			bright_fg = utils.get_highlight("Folded").fg,
			red = utils.get_highlight("DiagnosticError").fg,
			dark_red = utils.get_highlight("DiffDelete").bg,
			green = utils.get_highlight("String").fg,
			blue = utils.get_highlight("Function").fg,
			gray = utils.get_highlight("NonText").fg,
			orange = utils.get_highlight("Constant").fg,
			purple = utils.get_highlight("Statement").fg,
			cyan = utils.get_highlight("Special").fg,
			diag_warn = utils.get_highlight("DiagnosticWarn").fg,
			diag_error = utils.get_highlight("DiagnosticError").fg,
			diag_hint = utils.get_highlight("DiagnosticHint").fg,
			diag_info = utils.get_highlight("DiagnosticInfo").fg,
			git_del = utils.get_highlight("diffDeleted").fg,
			git_add = utils.get_highlight("diffAdded").fg,
			git_change = utils.get_highlight("diffChanged").fg,
		}

		-- Setup Heirline
		require("heirline").setup({
			opts = {
				colors = colors,
			},
			statusline = { -- Statusline
				hl = { fg = "fg", bg = "bg" },
				Git,
				FileNameComponent,
			},
			winbar = { -- Winbar
				hl = { fg = "fg", bg = "bg" },
				FileNameComponent,
			},
		})
	end,
}
