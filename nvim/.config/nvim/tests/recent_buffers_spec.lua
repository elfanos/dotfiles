local recent = require("rallmo-style.my_recent_buffer")

describe("my_recent_buffers", function()
	before_each(function()
		-- Reset before each test
		recent.recent_buffers = {}
	end)

	it("adds a new buffer to recent list", function()
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_set_current_buf(buf)

		recent.on_buf_enter()
		local recent_list = recent.get_recent()

		assert.are.same(1, #recent_list)
		assert.are.equal(buf, recent_list[1])
	end)

	it("moves an existing buffer to the front", function()
		local buf1 = vim.api.nvim_create_buf(false, true)
		local buf2 = vim.api.nvim_create_buf(false, true)

		vim.api.nvim_set_current_buf(buf1)
		recent.on_buf_enter()
		vim.api.nvim_set_current_buf(buf2)
		recent.on_buf_enter()
		vim.api.nvim_set_current_buf(buf1)
		recent.on_buf_enter()

		local recent_list = recent.get_recent()
		assert.are.equal(buf1, recent_list[1])
	end)

	it("keeps only the last 3 buffers", function()
		local buffers = {}
		for i = 1, 4 do
			local buf = vim.api.nvim_create_buf(false, true)
			table.insert(buffers, buf)
			vim.api.nvim_set_current_buf(buf)
			recent.on_buf_enter()
		end

		local recent_list = recent.get_recent()
		assert.are.same(3, #recent_list)
		assert.is_not.equal(buffers[1], recent_list[1]) -- buf1 should have been dropped
	end)

	it("filters out invalid or unnamed buffers", function()
		local valid_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(valid_buf, "/tmp/test.txt")
		vim.api.nvim_set_current_buf(valid_buf)
		recent.on_buf_enter()

		local invalid_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_delete(invalid_buf, { force = true }) -- invalidate it

		-- Manually insert invalid to simulate edge case
		table.insert(recent.recent_buffers, 1, invalid_buf)

		local recent_list = recent.get_recent()
		assert.are.same(1, #recent_list)
		assert.are.equal(valid_buf, recent_list[1])
	end)
end)
