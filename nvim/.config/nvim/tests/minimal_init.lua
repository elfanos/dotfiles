-- tests/minimal_init.lua

-- Add current directory (project root) to runtimepath
vim.cmd("set rtp+=.")

-- Optional: add plenary if not already managed by lazy.nvim or in your rtp
-- Change the path if needed (this assumes you use lazy.nvim)
vim.cmd("set rtp+=~/.local/share/nvim/lazy/plenary.nvim")

-- If your code is in `lua/`, it's already available from `rtp+=.`
-- So you don't need to require full config here unless needed

-- Minimal settings (optional)
vim.o.runtimepath = vim.o.runtimepath -- ensures any rtp changes apply
vim.cmd("filetype plugin indent on")  -- enable filetype plugins
vim.cmd("syntax on")                  -- syntax highlighting for buffer tests
