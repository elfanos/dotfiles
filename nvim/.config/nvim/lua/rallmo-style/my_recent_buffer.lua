
local M = {}
M.recent_buffers = {}

function M.on_buf_enter()
	local current_buf = vim.api.nvim_get_current_buf()
	--
	--
	--
	-- vim.print("Recent:", M.recent_buffers)
	-- Remove if already in list
	for i, buf in ipairs(M.recent_buffers) do
		if buf == current_buf then
			table.remove(M.recent_buffers, i)
			break
		end
	end

	-- Add to front
	table.insert(M.recent_buffers, 1, current_buf)
  vim.print("Entering buffer:", #M.recent_buffers)

	-- Trim to a maximum of 3 recent buffers
	if #M.recent_buffers > 3 then
		M.recent_buffers = { unpack(M.recent_buffers, 1, 3) }
	end
end

-- Returns valid and listed buffers only
function M.get_recent()
	local valid_buffers = {}
  vim.print(M.recent_buffers)
	for _, buf in ipairs(M.recent_buffers) do
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
			table.insert(valid_buffers, buf)
		end
	end
	vim.print("Recent valid buffers:", valid_buffers)
	return valid_buffers
end

return M
