local file_component = {}
function file_component.setup_file_components(conditions, utils)
	local FileNameBlock = {
		-- Let's first set up some attributes needed by this component and its children
		init = function(self)
			self.filename = vim.api.nvim_buf_get_name(0)
		end,
	}
	-- We can now define some children separately and add them later

	local FileIcon = {
		init = function(self)
			local filename = self.filename
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			return self.icon and (self.icon .. " ")
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	}

	local FileName = {
		provider = function(self)
			-- First, trim the pattern relative to the current directory. For other
			-- options, see :h filename-modifers
			local filename = vim.fn.fnamemodify(self.filename, ":.")
			if filename == "" then
				return "[No Name]"
			end
			-- Now, if the filename would occupy more than 1/4th of the available
			-- space, we trim the file path to its initials
			-- See Flexible Components section below for dynamic truncation
			if not conditions.width_percent_below(#filename, 0.25) then
				filename = vim.fn.pathshorten(filename)
			end
			return filename
		end,
		hl = { fg = utils.get_highlight("Directory").fg },
	}

	local FileFlags = {
		{
			condition = function()
				return vim.bo.modified
			end,
			provider = "[+]",
			hl = { fg = "green" },
		},
		{
			condition = function()
				return not vim.bo.modifiable or vim.bo.readonly
			end,
			provider = "",
			hl = { fg = "orange" },
		},
	}

	local FileNameModifier = {
		hl = function()
			if vim.bo.modified then
				-- Use `force` because we need to override the child's hl foreground
				return { fg = "cyan", bold = true, force = true }
			end
		end,
	}

	-- Return the components as a table
	return {
		FileNameBlock = FileNameBlock,
		FileIcon = FileIcon,
		FileName = FileName,
		FileFlags = FileFlags,
		FileNameModifier = FileNameModifier,
	}
end

return file_component
