local recent = require("rallmo-style.my_recent_buffer")

local function create_named_buf(name)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, name)
	return buf
end

describe("my_recent_buffers", function()
	before_each(function()
		recent.recent_buffers = {}
	end)

	it("adds a new buffer to recent list", function()
		local buf = create_named_buf("/tmp/testfile_1.lua")
		vim.cmd("buffer " .. buf) -- ✅ switch buffer properly
		recent.on_buf_enter()

		local recent_list = recent.get_recent()
		assert.are.same(1, #recent_list)
		assert.are.equal(buf, recent_list[1])
	end)

	it("moves an existing buffer to the front", function()
		local buf1 = create_named_buf("/tmp/testfile_2.lua")
		local buf2 = create_named_buf("/tmp/testfile_3.lua")

		vim.cmd("buffer " .. buf1)
		recent.on_buf_enter()
		vim.cmd("buffer " .. buf2)
		recent.on_buf_enter()
		vim.cmd("buffer " .. buf1)
		recent.on_buf_enter()

		local recent_list = recent.get_recent()
		assert.are.equal(buf1, recent_list[1])
	end)

	it("keeps only the last 3 buffers", function()
		local buffers = {}
		for i = 1, 4 do
			local buf = create_named_buf("/tmp/testfile_" .. i .. ".lua")
			table.insert(buffers, buf)
			vim.cmd("buffer " .. buf)
			recent.on_buf_enter()
		end

		local recent_list = recent.get_recent()
		assert.are.same(3, #recent_list)
		assert.is_not.equal(buffers[1], recent_list[1]) -- first buffer should be dropped
	end)

	it("filters out invalid or unnamed buffers", function()
		local valid_buf = create_named_buf("/tmp/valid_test.lua")
		vim.cmd("buffer " .. valid_buf)
		recent.on_buf_enter()

		local invalid_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_delete(invalid_buf, { force = true })

		table.insert(recent.recent_buffers, 1, invalid_buf)

		local recent_list = recent.get_recent()
		assert.are.same(1, #recent_list)
		assert.are.equal(valid_buf, recent_list[1])
	end)
end)
