-- DISABLE --
-- We don't need any of this stuff
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
----
---
--- fi

------------------------------------------------------------
-- Disable Python 2 provider
--
-- Someone else had this in their config, not sure if I need it? But I do like
-- turning stuff off...
------------------------------------------------------------
vim.g.loaded_python_provider = 0
vim.g.python_host_prog = vim.fs.joinpath("bin", "python2")
vim.g.python3_host_prog = vim.fs.joinpath("bin", "python")
vim.g.node_host_prog = vim.fs.joinpath("bin", "neovim-node-host")
--

-- Embrace , as our true and only leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Allow mouse to be used in all modes (default is "nvi")
vim.opt.mouse = 'a'

-- UI SETTINGS --

-- Show line numbers
vim.opt.number = true

-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Hide the mode indicator (e.g., -- INSERT --)
vim.opt.showmode = false

----

-- Hide the status bar at the bottom of the window
vim.opt.laststatus = 0

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Every wrapped line will continue visually indented (same amount of space as
-- the beginning of that line), thus preserving horizontal blocks of text.
vim.o.breakindent = true

------------------------------------------------------------
-- File management settings
------------------------------------------------------------

vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Enable undo files
vim.opt.undofile = true -- Disable swap files
vim.opt.swapfile = false -- Command history length
vim.opt.history = 2000 --- Number of commands to remember
vim.opt.autoread = true -- Auto-read files that have been changed outside

------------------------------------------------------------
-- Indentation and formatting
------------------------------------------------------------
vim.opt.smarttab = true  -- Smart tabbing based on shiftwidth
vim.opt.shiftround = true  -- Round indentation to the nearest shiftwidth
vim.opt.textwidth = 80  -- Maximum text width before line breaks
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.autoindent = true  -- Auto-indent new lines
vim.opt.tabstop = 2  -- Number of spaces per tab
vim.opt.shiftwidth = 2  -- Number of spaces per indentation level
vim.opt.softtabstop = -1  -- Adjust tab width during editing

-- Show tabs and other whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- By default ignore case in search, but if there's a capital (smartcase) then
-- treat it properly
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (signs are icons/color things you can put on the left hand side of the editor for wanrings and stuff)
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time (time in milliseconds to wait for a mapped sequence to complete)
vim.o.timeoutlen = 300

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.opt.formatoptions:append("j")  -- Join comments when appropriate
vim.opt.formatoptions:append("c")  -- Auto-wrap comments
vim.opt.formatoptions:append("r")  -- Auto-insert comment leader on Enter
vim.opt.formatoptions:append("o")  -- Auto-insert comment leader on o/O
vim.opt.formatoptions:append("q")  -- Allow formatting with gq

require("config.lazy")
-- require("config.netrw")

-- require("transparent").setup({
--   use_devicons = true,
--   enable = true,
-- })
--
-- require('jellybeans').setup({
--   transparent = true,
--   italics = false,
-- })

require("catppuccin").setup({
  transparent_background = true,
  no_italic = true,
  show_end_of_buffer = true
})

vim.cmd.colorscheme('catppuccin-mocha')

-- Shortcut to either switch to the current file in the sidebar if we're in the editor, of if we're in neotree, the same shortcut will switch back to the editor
vim.keymap.set('n', '<leader>r', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if string.match(bufname, 'neo%-tree') then
    vim.cmd('wincmd w')
  else
    vim.cmd('Neotree reveal_file=% reveal_force_cwd')
  end
end, { noremap = true, silent = true })

-- Custom keymaps for opening/closing directory view
vim.api.nvim_set_keymap( 'n', '<leader>s', ':Neotree toggle<cr>', { noremap = true, silent = true })

vim.keymap.set( 'n', '<leader>w', '<cmd>write<cr>', { desc = "Save file" })
vim.keymap.set( 'n', '<leader>q', '<cmd>quit<cr>', { desc = "Exit vim" })
vim.keymap.set( 'n', '<leader>wq', ':wq<cr>', { desc = "Exit vim" })

vim.keymap.set( 'n', '\\[', '<cmd>tabprevious<cr>', { desc = "Previous tab" })
vim.keymap.set( 'n', '\\]', '<cmd>tabnext<cr>', { desc = "Next tab" })
vim.keymap.set( 'n', '\\n', '<cmd>tabnew<cr>', { desc = "New tab" })

-- Shortcut `` to jump back to last buffer
vim.api.nvim_set_keymap( 'n', '``', '<C-^>', { noremap = true, silent = true })

-- Save 1000s of hours by making ; a shortcut to :
-- vim.api.nvim_set_keymap( 'n', ';', ':', { noremap = true, silent = true })


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
-- fil
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
