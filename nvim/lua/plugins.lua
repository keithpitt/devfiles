return {
  -- Nicer looking netrw with icons
  -- { 'nvim-tree/nvim-web-devicons', opts = {} },
  -- { 'prichrd/netrw.nvim', opts = {} },

  -- Force background of vim to be transparent
  { 'xiyaowong/transparent.nvim', opts = {} },

  -- Automatically make folders if they don't exist
  { 'jghauser/mkdir.nvim' },

  -- Figure out what the current indentation setup is automatically
  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup()
    end
  },

  -- Searching across all the files
  { 'duane9/nvim-rg' },

  -- Replacement for netrw
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",

      -- Add image support
      { "3rd/image.nvim", opts = {} },
    },
    -- neo-tree will lazily load itself
    lazy = false,
  },

  -- Best theme ever
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = { }
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  -- Kinda like ctrl-p
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'smartpde/telescope-recent-files',
        commit = 'eb190c0baded1cbfa9d8767c817b054377683163'
      }
    },
    config = function()
      require("telescope").load_extension("recent_files")
    end
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },

  -- Removes trailing white space and empty lines at EOF on save
  {
    'mcauley-penney/tidy.nvim',
    config = true,
  },

  -- LSP auto configs
  {
    'neovim/nvim-lspconfig',
  },

  -- Bunch of random cool extras
  {
    'echasnovski/mini.nvim',
    version = '*'
  },

  -- Better autochdir
  {
    'airblade/vim-rooter',
  },

  -- Sync terminal background color with nvim
  {
    'typicode/bg.nvim',
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      notifier = { enabled = true },
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>z",
        "<cmd>Trouble diagnostics toggle preview_float<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>x",
        "<cmd>Trouble next diagnostics<cr>",
        desc = "Diagnostics next in list (Trouble)",
      },
      -- {
      --   "<leader>xX",
      --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      --   desc = "Buffer Diagnostics (Trouble)",
      -- },
      -- {
      --   "<leader>cs",
      --   "<cmd>Trouble symbols toggle focus=false<cr>",
      --   desc = "Symbols (Trouble)",
      -- },
      -- {
      --   "<leader>cl",
      --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      --   desc = "LSP Definitions / references / ... (Trouble)",
      -- },
      -- {
      --   "<leader>xL",
      --   "<cmd>Trouble loclist toggle<cr>",
      --   desc = "Location List (Trouble)",
      -- },
      -- {
      --   "<leader>xQ",
      --   "<cmd>Trouble qflist toggle<cr>",
      --   desc = "Quickfix List (Trouble)",
      -- },
    },
  },
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
