vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.cmd("set belloff=all")

vim.g.mapleader = " "
vim.g.maplocalleader = "-"

vim.opt.guicursor = ""

vim.opt.swapfile = false
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.g.netrw_sizestyle = "h"

vim.g.godot_executable = "~/computer/games/engine/godot/bin/godot.macos.editor.arm64"
vim.g.python3_host_prog = "/Library/Developer/CommandLineTools/usr/bin/python3"

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.opt.guifont = "Meslo LGS Nerd Font Mono:h16"

-- vim.opt.guicursor = {
-- 	"n-v-c:block-blinkon0",
-- 	"i-ci-ve:ver25-blinkon0",
-- 	"r-cr:hor20-blinkon0",
-- 	"o:hor50-blinkon0",
-- }
