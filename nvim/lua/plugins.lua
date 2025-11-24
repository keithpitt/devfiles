return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",

  --   dependencies = {
  --     "virchau13/tree-sitter-astro",
  --   },

  --   build = ":TSUpdate",

  --   opts = {
  --     ensure_installed = {
  --       "typescript",
  --       "python",
  --       "rust",
  --       "go",
  --       "ruby",
  --       "bash",
  --     },
  --     sync_install = false,
  --     auto_install = true,
  --     highlight = {
  --       enable = true,
  --     },
  --     indent = {
  --       enable = true,
  --     },
  --   },

  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  -- },

  -- {
  --   "habamax/vim-asciidoctor",
  -- },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {
  --     options = {
  --       disabled_filetypes = { "neo-tree", "trouble" },
  --       ignore_focus = { "neo-tree", "trouble", "telescope" },
  --     },
  --     sections = {
  --       lualine_a = {
  --         {
  --           "lsp_status",
  --           icon = "", -- f013
  --           symbols = {
  --             -- Standard unicode symbols to cycle through for LSP progress:
  --             spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  --             -- Standard unicode symbol for when LSP is done:
  --             done = "✓",
  --             -- Delimiter inserted between LSP names:
  --             separator = " ",
  --           },
  --           -- List of LSP names to ignore (e.g., `null-ls`):
  --           ignore_lsp = {},
  --         },
  --       },
  --     },
  --   },
  -- },

  -- Nicer looking netrw with icons
  -- { 'nvim-tree/nvim-web-devicons', opts = {} },
  -- {
  --   "prichrd/netrw.nvim",
  --   config = function()
  --     require("netrw").setup({
  --       -- File icons to use when `use_devicons` is false or if
  --       -- no icon is found for the given file type.
  --       -- icons = {
  --       --   symlink = "",
  --       --   directory = "",
  --       --   file = "",
  --       -- },
  --       -- Uses mini.icon or nvim-web-devicons if true, otherwise use the file icon specified above
  --       use_devicons = true,
  --       -- mappings = {
  --       --   -- Function mappings receive an object describing the node under the cursor
  --       --   ['p'] = function(payload) print(vim.inspect(payload)) end,
  --       --   -- String mappings are executed as vim commands
  --       --   ['<Leader>p'] = ":echo 'hello world'<CR>",
  --       -- },
  --     })
  --   end,
  -- },

  -- Force background of vim to be transparent
  -- { "xiyaowong/transparent.nvim", opts = {} },

  -- Automatically make folders if they don't exist
  { "jghauser/mkdir.nvim" },

  -- Figure out what the current indentation setup is automatically
  -- {
  --   'nmac427/guess-indent.nvim',
  --   config = function()
  --     require('guess-indent').setup()
  --   end
  -- },

  -- Searching across all the files
  { "duane9/nvim-rg" },

  -- Replacement for netrw
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",

  --     -- Add image support
  --     { "3rd/image.nvim", opts = {} },
  --   },
  --   -- neo-tree will lazily load itself
  --   lazy = false,

  --   opts = {
  --     -- If we've closed our last buffer, then our work here is done
  --     close_if_last_window = true,

  --     -- A more tighter window
  --     -- window = {
  --     -- width = "fit_content",
  --     -- },

  --     filesystem = {
  --       -- Make "nvim ." work better
  --       hijack_netrw_behavior = "open_current",

  --       -- Use telescope for search
  --       window = {
  --         mappings = {
  --           -- disable fuzzy finder
  --           ["/"] = "noop",
  --         },
  --       },

  --       -- Ensure the sidebar's working directory is the same as the current file
  --       bind_to_cwd = true,
  --       cwd_target = {
  --         sidebar = "tab",
  --         current = "window",
  --       },

  --       filtered_items = {
  --         visible = true,
  --         -- hide_dotfiles = false,
  --         never_show = {
  --           ".DS_Store",
  --           "thumbs.db",
  --         },
  --       },
  --     },
  --   },
  --
  --   config = function()
  -- Shortcut to either switch to the current file in the sidebar if we're in the editor, of if we're in neotree, the same shortcut will switch back to the editor
  -- vim.keymap.set("n", "<leader>r", function()
  --   local bufname = vim.api.nvim_buf_get_name(0)
  --   if string.match(bufname, "neo%-tree") then
  --     vim.cmd("wincmd w")
  --   else
  --     vim.cmd("Neotree reveal_file=% reveal_force_cwd")
  --   end
  -- end, { noremap = true, silent = true })
  --
  -- -- Custom keymaps for opening/closing directory view
  -- vim.api.nvim_set_keymap("n", "<leader>s", ":Neotree toggle<cr>", { noremap = true, silent = true })
  --   end
  -- },

  -- Kinda like ctrl-p
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   tag = "0.1.8",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     {
  --       "smartpde/telescope-recent-files",
  --       commit = "eb190c0baded1cbfa9d8767c817b054377683163",
  --     },
  --   },
  --   config = function()
  --     require("telescope").load_extension("recent_files")

  --     local telescope_actions = require("telescope.actions")
  --     local telescope_builtin = require("telescope.builtin")

  --     require("telescope").setup({
  --       defaults = {
  --         mappings = {
  --           i = {
  --             -- Escape telescope with <ESC> when in insert mode (otherwise you need
  --             -- to hit it twice which is kinda annoying)
  --             ["<esc>"] = telescope_actions.close,
  --           },
  --         },
  --         preview = {
  --           -- Hide previewer when picker starts
  --           hide_on_startup = true,
  --         },
  --       },
  --       extensions = {
  --         recent_files = {
  --           ignore_patterns = { "/tmp/", ".git" },
  --           theme = "dropdown",
  --         },
  --       },
  --     })

  --     require("telescope").load_extension("recent_files")

  --     -- Custom keymaps for toggling telescope
  --     -- vim.keymap.set('n', '<leader>f', ':Telescope frecency workspace=CWD <cr>', { desc = 'Telescope find files', silent = true, noremap = true })
  --     vim.keymap.set("n", "<leader>f", function()
  --       require("telescope").extensions.recent_files.pick({ only_cwd = true })
  --     end, { noremap = true, silent = true })
  --     vim.keymap.set(
  --       "n",
  --       "<leader>l",
  --       telescope_builtin.oldfiles,
  --       { desc = "Telescope old files", silent = true }
  --     )
  --     vim.keymap.set(
  --       "n",
  --       "<leader>d",
  --       telescope_builtin.lsp_workspace_symbols,
  --       { desc = "Telescope lsp workspace symbols", silent = true }
  --     )
  --   end,
  -- },

  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   version = "*",
  --   config = function()
  --     require("telescope").load_extension("frecency")
  --   end,
  -- },

  -- Removes trailing white space and empty lines at EOF on save
  -- {
  --   "mcauley-penney/tidy.nvim",
  --   config = true,
  -- },

  -- Some LSPs don't support formatting, this fills the gaps

  -- Bunch of random cool extras
  -- {
  --   "echasnovski/mini.nvim",
  --   version = "*",
  -- },

  -- Better autochdir
  -- {
  --   "airblade/vim-rooter",
  -- },

  -- Sync terminal background color with nvim
  -- {
  --   "typicode/bg.nvim",
  -- },

  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } },
  -- },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Pretty vim.notify
      notifier = { enabled = true },
      -- Auto-show LSP references and quickly navigate between them
      words = { enabled = true },
      -- Auto-show LSP references and quickly navigate between them
      picker = {
        enabled = true,
        sources = {
          explorer = {
            -- follow_file = false,
            -- auto_close = true,
            hidden = true,
            -- ignored = true,
          },
          files = {
            -- follow_file = false,
            auto_close = true,
            -- hidden = true,
            -- ignored = true,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["``"] = function()
                -- Switch to the previous window (main editor)
                vim.cmd("wincmd p")
              end,
            },
          },
        },
      },
      -- A file explorer (picker in disguise)
      explorer = {
        enabled = true,
        replace_netrw = true,
        win = {
          input = {
            keys = {
              ["<leader>b"] = "picker_grep",
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>l",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>~",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>f",
        function()
          Snacks.picker.files()
        end,
        desc = "Recent",
      },
      {
        "<leader>r",
        function()
          Snacks.explorer.open()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>g",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
    },
  },
  -- {
  --   "folke/trouble.nvim",
  --   opts = {
  --     focus = true,
  --     modes = {
  --       preview_float = {
  --         mode = "diagnostics",
  --         preview = {
  --           type = "float",
  --           relative = "editor",
  --           border = "rounded",
  --           title = "Preview",
  --           title_pos = "center",
  --           position = { 0, -2 },
  --           size = { width = 0.3, height = 0.3 },
  --           zindex = 200,
  --         },
  --       },
  --     },
  --   }, -- for default options, refer to the configuration section for custom setup.
  --   cmd = "Trouble",
  --   keys = {
  --     {
  --       "<leader>z",
  --       "<cmd>Trouble diagnostics toggle preview_float<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>x",
  --       "<cmd>Trouble next diagnostics<cr>",
  --       desc = "Diagnostics next in list (Trouble)",
  --     },
  --     -- {
  --     --   "<leader>xX",
  --     --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --     --   desc = "Buffer Diagnostics (Trouble)",
  --     -- },
  --     -- {
  --     --   "<leader>cs",
  --     --   "<cmd>Trouble symbols toggle focus=false<cr>",
  --     --   desc = "Symbols (Trouble)",
  --     -- },
  --     -- {
  --     --   "<leader>cl",
  --     --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --     --   desc = "LSP Definitions / references / ... (Trouble)",
  --     -- },
  --     -- {
  --     --   "<leader>xL",
  --     --   "<cmd>Trouble loclist toggle<cr>",
  --     --   desc = "Location List (Trouble)",
  --     -- },
  --     -- {
  --     --   "<leader>xQ",
  --     --   "<cmd>Trouble qflist toggle<cr>",
  --     --   desc = "Quickfix List (Trouble)",
  --     -- },
  --   },
  -- },
  -- { -- Useful plugin to show you pending keybinds.
  --   'folke/which-key.nvim',
  --   event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  --   opts = {
  --     -- delay between pressing a key and opening which-key (milliseconds)
  --     -- this setting is independent of vim.o.timeoutlen
  --     delay = 0,
  --     icons = {
  --       -- set icon mappings to true if you have a Nerd Font
  --       mappings = true,
  --       -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
  --       -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
  --       keys = {}
  --     },

  --     -- Document existing key chains
  --     spec = {
  --       { '<leader>s', group = '[S]earch' },
  --       { '<leader>t', group = '[T]oggle' },
  --       { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  --     },
  --   },
  --   -- keys = {
  --   --   {
  --   --     "<leader><leader>",
  --   --     function()
  --   --       require("which-key").show({ global = false })
  --   --     end,
  --   --     desc = "Buffer Local Keymaps (which-key)",
  --   --   },
  --   -- },
  -- },
}
