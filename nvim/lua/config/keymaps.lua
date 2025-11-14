-- Exit vim remappings
vim.keymap.set("n", "\\[", "<cmd>tabprevious<cr>", { desc = "Previous tab", silent = true })
vim.keymap.set("n", "\\]", "<cmd>tabnext<cr>", { desc = "Next tab", silent = true })
vim.keymap.set("n", "\\n", "<cmd>tabnew<cr>", { desc = "New tab", silent = true })

vim.keymap.set("n", "<esc>", ":noh<cr>", {
  desc = "Remove search highlights in normal mode",
  silent = true,
})

-- Shortcut `` to jump back to last buffer
vim.api.nvim_set_keymap("n", "``", "<C-^>", { noremap = true, silent = true })

-- Save 1000s of hours by making ; a shortcut to :
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })

-- Replace q! with qa! (quit all)
vim.cmd("cabbrev q! qa!")

-- Inspired from:
-- http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  '":e " .. expand("%:p:h") .. "/"',
  { noremap = true, expr = true }
)