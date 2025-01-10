vim.keymap.set("n","<leader>gs",vim.cmd.Git)

return {
   "tpope/vim-fugitive",
   conifg = function()
      vim.keymap.set("n","<leader>gs",vim.cmd.Git)
   end
}
