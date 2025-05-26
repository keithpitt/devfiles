require("netrw").setup({
  use_devicons = true,
})

-- Netrw banner
-- 0 : Disable banner
-- 1 : Enable banner
vim.g.netrw_banner = 0

-- Keep the current directory and the browsing directory synced.
-- This helps you avoid the move files error.
vim.g.netrw_keepdir = 0

-- Show directories first (sorting)
vim.g.netrw_sort_sequence = [[[\/]$,*]]

-- Human-readable files sizes
vim.g.netrw_sizestyle = "H"

-- Netrw list style
-- 0 : thin listing (one file per line)
-- 1 : long listing (one file per line with timestamp information and file size)
-- 2 : wide listing (multiple files in columns)
-- 3 : tree style listing
vim.g.netrw_liststyle = 3

-- Patterns for hiding files, e.g. node_modules
-- NOTE: this works by reading '.gitignore' file
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()
