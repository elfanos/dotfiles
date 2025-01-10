



local mode = function()
    return vim.api.nvim_get_mode().mode;
end

-- Explorer
vim.keymap.set({"n","v"}, "<localleader>e", function ()
    if mode() == "v" then
        vim.cmd('normal! "\\"<esc>"\\"')
        vim.cmd.Ex()
    end
    vim.cmd.Ex()
end)

local vex = function ()
    vim.cmd(":Vexplore <cr>")
end
--- Vexplore keymaps
vim.keymap.set({"n","v"}, "<localleader>v", function ()

    if mode() == "v" then
        vim.cmd('normal! "\\"<esc>"\\"')
    end
    vex()
end)


local hex = function ()
    vim.cmd(":Hexplore <cr>")
end
--- Hexplore keyraps
vim.keymap.set({"n","v"}, "<localleader>h", function ()

    if mode() == "v" then
        vim.cmd('normal! "\\"<esc>"\\"')
    end
    hex()
end)

-- Add a comment above the current line
vim.keymap.set('n', '<leader>nt', function()
    local line = vim.fn.line('.') -- Get the current line number
    vim.fn.append(line - 1, '// #FixThisInPr') -- Add the comment above the current line
end, { desc = '[N]ote [T]odo: Add "// #FixThisInPr" above current line' })

-- Search for "// #FixThisInPr" using Telescope's grep_string
vim.keymap.set('n', '<leader>ng', function()
    require('telescope.builtin').grep_string {
        search = '// #FixThisInPr',
        prompt_title = 'Search for "// #FixThisInPr"',
    }
end, { desc = '[N]ote [G]rep: Search for "// #FixThisInPr"' })





