vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

require("config.lazy")
-- require("config.netrw")

-- require("transparent").setup({
--   use_devicons = true,
--   enable = true,
-- })

vim.cmd.colorscheme('jellybeans')

-- Custom keymaps for opening/closing directory view
vim.api.nvim_set_keymap( 'n', ',r', ':Neotree reveal_file=% reveal_force_cwd<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', ',s', ':Neotree reveal_file=% reveal_force_cwd<cr>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap( 'n', ',s', ':Neotree toggle<cr>', { noremap = true, silent = true })

-- Shortcut `` to jump back to last buffer
vim.api.nvim_set_keymap( 'n', '``', '<C-^>', { noremap = true, silent = true })

-- Save 1000s of hours by making ; a shortcut to :
vim.api.nvim_set_keymap( 'n', ';', ':', { noremap = true, silent = true })

-- Allow mouse to be used in all modes (default is "nvi")
vim.opt.mouse = 'a'

-- Show line numbers
vim.opt.number = true

-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Hide the status bar at the bottom of the window
vim.opt.laststatus = 0

require('telescope').setup({
  defaults = {
    preview = {
      -- Hide previewer when picker starts
      hide_on_startup = true
    }
  }
})

-- Custom keymaps for toggling telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', ',t', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', ',f', builtin.oldfiles, { desc = 'Telescope old files' })

-- There is only 1 correct config for tabs, and this is it
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- By default ignore case in search, but if there's a capital (smartcase) then
-- treat it properly
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.lsp.enable('bashls')
vim.lsp.config('bashls', {
  settings = {
    includeAllWorkspaceSymbols = true
  }
})

vim.opt.autochdir = true

vim.diagnostic.config({ virtual_lines = true })

require('mini.completion').setup()
require('mini.snippets').setup()
require('mini.icons').setup()

require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = true,
    hijack_netrw_behavior = "open_current",
    cwd_target = {
      sidebar = "tab",
      current = "window"
    },
  }
})
