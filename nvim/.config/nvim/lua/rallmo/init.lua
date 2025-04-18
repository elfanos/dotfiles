require("rallmo.remap")
require("rallmo.set")
require("rallmo.quickfix-rallmo")
vim.api.nvim_create_user_command("CopyRelPath", function() vim.api.nvim_call_function("setreg", {"+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.")}) end, {})

-- Function to copy the filename under the cursor in netrw to clipboard
function CopyFilenameToClipboard()
  -- Get the name of the file under the cursor
  local filename = vim.fn.expand('<cfile>')
  if filename == '' then
    print("No file selected.")
    return
  end
  vim.fn.setreg('+', filename)
  print("Copied: " .. filename)
end

-- Map the function to a key (e.g., <leader>y) in netrw
vim.api.nvim_exec([[
  augroup NetrwMappings
    autocmd!
    autocmd FileType netrw nnoremap <silent> <leader>y :lua CopyFilenameToClipboard()<CR>
  augroup END
]], false)
