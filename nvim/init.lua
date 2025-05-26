-- Disable netrw entirely since we use neotree
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Embrace , as our true and only leader
vim.g.mapleader = ','

require("config.lazy")
-- require("config.netrw")

-- require("transparent").setup({
--   use_devicons = true,
--   enable = true,
-- })
--
require('jellybeans').setup({
  transparent = true,
  italics = false,
})

vim.cmd.colorscheme('jellybeans')

-- Custom keymaps for opening/closing directory view
vim.keymap.set( 'n', '<leader>r', ':Neotree reveal_file=% reveal_force_cwd<cr>', { noremap = true, silent = true })
-- vim.keymap.set( 'n', '<leader>s', ':Neotree reveal_file=% reveal_force_cwd<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', ',s', ':Neotree toggle<cr>', { noremap = true, silent = true })
--
vim.keymap.set( 'n', '<leader>w', '<cmd>write<cr>', { desc = "Save file" })
vim.keymap.set( 'n', '<leader>q', '<cmd>quitall<cr>', { desc = "Exit vim" })

-- Shortcut `` to jump back to last buffer
vim.api.nvim_set_keymap( 'n', '``', '<C-^>', { noremap = true, silent = true })

-- Save 1000s of hours by making ; a shortcut to :
-- vim.api.nvim_set_keymap( 'n', ';', ':', { noremap = true, silent = true })

-- Allow mouse to be used in all modes (default is "nvi")
vim.opt.mouse = 'a'

-- Show line numbers
vim.opt.number = true

-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Hide the status bar at the bottom of the window
vim.opt.laststatus = 0

local telescope_actions = require("telescope.actions")
local telescope_builtin = require('telescope.builtin')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        -- Escape telescope with <ESC> when in insert mode (otherwise you need
        -- to hit it twice which is kinda annoying)
        ["<esc>"] = telescope_actions.close
      },
    },
    preview = {
      -- Hide previewer when picker starts
      hide_on_startup = true
    }
  }
})

-- Custom keymaps for toggling telescope
vim.keymap.set('n', '<leader>f', ':Telescope frecency workspace=CWD <cr>', { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>l', telescope_builtin.oldfiles, { desc = 'Telescope old files' })
vim.keymap.set('n', '<leader>d', telescope_builtin.lsp_workspace_symbols, { desc = 'Telescope lsp workspace symbols' })

-- There is only 1 correct config for tabs, and this is it
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Show tabs
vim.opt.list = true
vim.opt.listchars = 'tab:>-'

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

vim.lsp.enable('vimls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
    },
  }
})

vim.lsp.enable('lua_ls')

-- Automatically switch the vim working directory when we open a new file
-- vim.opt.autochdir = true

-- Show LSP errors
vim.diagnostic.config({ virtual_lines = true })

-- Setup autocomplete
require('mini.completion').setup()

local imap_expr = function(lhs, rhs)
  vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

require('mini.snippets').setup()
require('mini.icons').setup()

require("neo-tree").setup({
  window = {
    width = 30,
  },
  filesystem = {
    -- If we've closed our last buffer, then our work here is done
    close_if_last_window = true,

    -- Make "nvim ." work better
    hijack_netrw_behavior = "open_current",

    -- Ensure the sidebar's working directory is the same as the current file
    bind_to_cwd = true,
    cwd_target = {
      sidebar = "tab",
      current = "window"
    },
  }
})
