-- https://github.com/drakeaxelrod/nvim/blob/f34a9fe852162147ca64d0f52a4003459d4d0329/lua/core/opts.lua

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
--- fil asdf asdfasdf asdfasdf asdfasdf asdfas

--- sadfasdfasd sadfasdf asdfasdfas dfasdfasdf asdfasdfasdf
--- asdf asdfasdf asdf asadf asdfasdf asdfasdfa sdfasdf

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
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Allow mouse to be used in all modes (default is "nvi")
vim.opt.mouse = "a"

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
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

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
vim.opt.smarttab = true -- Smart tabbing based on shiftwidth
vim.opt.shiftround = true -- Round indentation to the nearest shiftwidth
vim.opt.textwidth = 80 -- Maximum text width before line breaks
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.autoindent = true -- Auto-indent new lines
vim.opt.tabstop = 2 -- Number of spaces per tab
vim.opt.shiftwidth = 2 -- Number of spaces per indentation level
vim.opt.softtabstop = -1 -- Adjust tab width during editing

-- Show tabs and other whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- By default ignore case in search, but if there's a capital (smartcase) then
-- treat it properly
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (signs are icons/color things you can put on the left hand side of the editor for wanrings and stuff)
vim.o.signcolumn = "yes"

-- Rounded boders everywhere
vim.o.winborder = "rounded"

-- Decrease update time
vim.o.updatetime = 250

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

------------------------------------------------------------
-- Timeout settings for key mappings
------------------------------------------------------------
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 300 -- Wait time in ms for key sequences
vim.opt.ttimeoutlen = 10 -- Time in ms for key code sequence

------------------------------------------------------------
-- Auto completion
------------------------------------------------------------

-- Completion options
vim.opt.completeopt = { "menu", "menuone", "noselect", "nosort" }

-- Allow cursor movement across line ends
vim.opt.whichwrap:append("<,>,[,],~")

------------------------------------------------------------
-- Auto format
------------------------------------------------------------
vim.opt.formatoptions:append("j") -- Join comments when appropriate
vim.opt.formatoptions:append("c") -- Auto-wrap comments
vim.opt.formatoptions:append("r") -- Auto-insert comment leader on Enter
vim.opt.formatoptions:append("o") -- Auto-insert comment leader on o/O
vim.opt.formatoptions:append("q") -- Allow formatting with gq

require("config.lazy")

require("lualine").setup()

-- some stuff so code folding uses treesitter instead of older methods
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

require("conform").setup({
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_format = "fallback",
    timeout_ms = 500,
  },
  formatters_by_ft = {
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    javascript = { "prettier" },
    toml = { "prettier" },
    lua = { "stylua" },
    -- etc
  },
})

-- require("config.netrw")

-- require("transparent").setup({
--   use_devicons = true,
--   enable = true,
-- })
--
require("jellybeans").setup({
  italics = false,
  -- on_colors = function(c)
  --   c.foreground = "#ffffff"
  -- end,
})
vim.cmd.colorscheme("jellybeans")

-- require("catppuccin").setup({
--   -- transparent_background = true,
--   no_italic = true,
--   show_end_of_buffer = true
-- })
--
-- vim.cmd.colorscheme('catppuccin-mocha')

-- Shortcut to either switch to the current file in the sidebar if we're in the editor, of if we're in neotree, the same shortcut will switch back to the editor
vim.keymap.set("n", "<leader>r", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if string.match(bufname, "neo%-tree") then
    vim.cmd("wincmd w")
  else
    vim.cmd("Neotree reveal_file=% reveal_force_cwd")
  end
end, { noremap = true, silent = true })

-- Custom keymaps for opening/closing directory view
vim.api.nvim_set_keymap("n", "<leader>s", ":Neotree toggle<cr>", { noremap = true, silent = true })

-- vim.keymap.set( 'n', ';', ':', { desc = "Exit vim" })

vim.keymap.set("n", "\\[", "<cmd>tabprevious<cr>", { desc = "Previous tab", silent = true })
vim.keymap.set("n", "\\]", "<cmd>tabnext<cr>", { desc = "Next tab", silent = true })
vim.keymap.set("n", "\\n", "<cmd>tabnew<cr>", { desc = "New tab", silent = true })

vim.keymap.set("n", "<esc>", ":noh<cr>", { desc = "Remove search highlights in normal mode", silent = true })

-- Shortcut `` to jump back to last buffer
vim.api.nvim_set_keymap("n", "``", "<C-^>", { noremap = true, silent = true })

-- Save 1000s of hours by making ; a shortcut to :
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })

local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        -- Escape telescope with <ESC> when in insert mode (otherwise you need
        -- to hit it twice which is kinda annoying)
        ["<esc>"] = telescope_actions.close,
      },
    },
    preview = {
      -- Hide previewer when picker starts
      hide_on_startup = true,
    },
  },
  extensions = {
    recent_files = {
      ignore_patterns = { "/tmp/", ".git" },
      theme = "dropdown",
    },
  },
})

require("telescope").load_extension("recent_files")

-- Custom keymaps for toggling telescope
-- vim.keymap.set('n', '<leader>f', ':Telescope frecency workspace=CWD <cr>', { desc = 'Telescope find files', silent = true, noremap = true })
vim.keymap.set("n", "<leader>f", function()
  require("telescope").extensions.recent_files.pick({ only_cwd = true })
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", telescope_builtin.oldfiles, { desc = "Telescope old files", silent = true })
vim.keymap.set(
  "n",
  "<leader>d",
  telescope_builtin.lsp_workspace_symbols,
  { desc = "Telescope lsp workspace symbols", silent = true }
)

-- vim.lsp.enable("jsonls")
--
-- vim.lsp.enable("bashls")
-- vim.lsp.config("bashls", {
--   settings = {
--     includeAllWorkspaceSymbols = true,
--   },
-- })
--
-- vim.lsp.enable("vimls")
--
-- vim.lsp.config("lua_ls", {
--   settings = {
--     Lua = {
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { "vim" },
--       },
--     },
--   },
-- })
-- vim.lsp.enable("lua_ls")
--
-- vim.lsp.enable("gopls")
--
-- vim.lsp.enable("ts_ls")
--
-- vim.lsp.enable("astro")
--
-- vim.lsp.enable("tailwindcss")

-- Automatically switch the vim working directory when we open a new file
-- fil
-- vim.opt.autochdir = true

-- It's good practice to namespace custom handlers to avoid collisions
-- vim.diagnostic.handlers["my/notify"] = {
--   show = function(namespace, bufnr, diagnostics, opts)
--     -- In our example, the opts table has a "log_level" option
--     local level = opts["my/notify"].log_level
--     local name = vim.diagnostic.get_namespace(namespace).name
--     local msg = string.format("%d diagnostics in buffer %d from %s",
--                               #diagnostics,
--                               bufnr,
--                               name)
--     vim.notify(msg, level)
--   end,
-- }

-- Show LSP errors
-- vim.diagnostic.config({ virtual_lines = true })

-- vim.diagnostic.config({
--   ["my/notify"] = {
--     log_level = vim.log.levels.INFO,
--     -- This handler will only receive "error" diagnostics.
--     severity = vim.diagnostic.severity.ERROR,
--   }
-- })
--
-- vim.diagnostic.config({ float = { border = "single" } })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

vim.lsp.inlay_hint.enable(true)

-- https://github.com/echasnovski/mini.completion/tree/main
-- local mini_completion = require('mini.completion')

-- local kind_priority = { Text = -1, Snippet = 99 }
-- local opts = { filtersort = 'fuzzy', kind_priority = kind_priority }
--
-- local imap_expr = function(lhs, rhs)
--   vim.keymap.set('i', lhs, rhs, { expr = true })
-- end
--
-- imap_expr('<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
-- imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
--
-- mini_completion.setup({
--   delay = { completion = 100, info = 0, signature = 0 },
--
--   fallback_action = '',
--
--   lsp_completion = {
--     --source_func = 'omnifunc',
--     --auto_setup = false,
--     process_items = function(items, base)
--       return mini_completion.default_process_items(items, base, opts)
--     end,
--   }
-- })

-- local snippets = require('mini.snippets')
-- snippets.start_lsp_server()
-- snippets.setup()

-- local icons = require('mini.icons')
-- icons.mock_nvim_web_devicons()
-- icons.tweak_lsp_kind()
-- icons.setup()

require("neo-tree").setup({
  -- If we've closed our last buffer, then our work here is done
  close_if_last_window = true,

  -- A more tighter window
  window = {
    width = 25,
  },

  filesystem = {
    -- Make "nvim ." work better
    hijack_netrw_behavior = "open_current",

    -- Ensure the sidebar's working directory is the same as the current file
    bind_to_cwd = true,
    cwd_target = {
      sidebar = "tab",
      current = "window",
    },

    filtered_items = {
      visible = true,
      -- hide_dotfiles = false,
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
    },
  },
})

-- local transparent = require("transparent")
-- transparent.clear_prefix('NeoTree')
-- transparent.setup()

-- vim.api.nvim_create_autocmd('VimEnter',{
--   callback=function()
--     if vim.fn.argc() == 0 then
--       require('telescope').extensions['recent-files'].recent_files(require('telescope.themes').get_dropdown({}))
--     end
--   end
-- })
--
local dashboard_custom_header = [[
                            ███╗   ███╗ █████╗  ██████╗ ██╗ ██████╗██╗  ██╗███████╗██╗████████╗██╗  ██╗
                            ████╗ ████║██╔══██╗██╔════╝ ██║██╔════╝██║ ██╔╝██╔════╝██║╚══██╔══╝██║  ██║
                            ██╔████╔██║███████║██║  ███╗██║██║     █████╔╝ █████╗  ██║   ██║   ███████║
                            ██║╚██╔╝██║██╔══██║██║   ██║██║██║     ██╔═██╗ ██╔══╝  ██║   ██║   ██╔══██║
                            ██║ ╚═╝ ██║██║  ██║╚██████╔╝██║╚██████╗██║  ██╗███████╗██║   ██║   ██║  ██║
                            ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝   ╚═╝  ╚═╝
                            ]]

require("dashboard").setup({
  theme = "hyper",
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
  change_to_vcs_root = true,
  config = {
    header = vim.split(dashboard_custom_header, "\n"),
    project = {
      action = function(path)
        require("telescope").extensions.recent_files.pick({ cwd = path, only_cwd = true })
      end,
    },
    shortcut = {
      { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
      -- {
      --   icon = ' ',
      --   icon_hl = '@variable',
      --   desc = 'Files',
      --   group = 'Label',
      --   action = 'Telescope recent_files',
      --   key = 'f',
      -- },
      -- {
      --   desc = ' Apps',
      --   group = 'DiagnosticHint',
      --   action = 'Telescope app',
      --   key = 'a',
      -- },
      -- {
      --   desc = ' dotfiles',
      --   group = 'Number',
      --   action = 'Telescope dotfiles',
      --   key = 'd',
      -- },
    },
  },
})

vim.api.nvim_create_augroup("Dashboard_au", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  group = "Dashboard_au",
  pattern = "dashboard",
  callback = function()
    vim.opt_local.ruler = false
    vim.opt_local.fillchars:append({ eob = " " })
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = "Dashboard_au",
  callback = function()
    vim.opt_local.ruler = true
  end,
})

-- require("tree-sitter-astro")
