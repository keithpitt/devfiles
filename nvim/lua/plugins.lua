return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  { "nvim-lualine/lualine.nvim" }, -- status line

  -- Nicer looking netrw with icons
  -- { 'nvim-tree/nvim-web-devicons', opts = {} },
  -- { 'prichrd/netrw.nvim', opts = {} },

  -- Force background of vim to be transparent
  { "xiyaowong/transparent.nvim", opts = {} },

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
    opts = {},
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- Kinda like ctrl-p
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "smartpde/telescope-recent-files",
        commit = "eb190c0baded1cbfa9d8767c817b054377683163",
      },
    },
    config = function()
      require("telescope").load_extension("recent_files")
    end,
  },

  {
    "virchau13/tree-sitter-astro",
    version = "*",
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },

  -- Removes trailing white space and empty lines at EOF on save
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },

  -- LSPs
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "jsonls",
        "bashls",
        "vimls",
        "lua_ls",
        "gopls",
        "ts_ls",
        "astro",
        "tailwindcss",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
      {
        "neovim/nvim-lspconfig",
        config = function()
          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    },
  },

  -- Some LSPs don't support formatting, this fills the gaps
  { "stevearc/conform.nvim" },

  -- Bunch of random cool extras
  {
    "echasnovski/mini.nvim",
    version = "*",
  },

  -- Better autochdir
  {
    "airblade/vim-rooter",
  },

  -- Sync terminal background color with nvim
  {
    "typicode/bg.nvim",
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      notifier = { enabled = true },
    },
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
  --
  -- Autocomplete engine (LSP, snippets etc)
  -- see keymap:
  -- https://cmp.saghen.dev/configuration/keymap.html#default
  {
    {
      "saghen/blink.cmp",
      -- optional: provides snippets for the snippet source
      dependencies = {
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
        "nvim-tree/nvim-web-devicons",
      },

      -- use a release tag to download pre-built binaries
      version = "1.*",
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          preset = "enter",
          ["<Tab>"] = { "select_and_accept" },
        },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = "mono",
        },

        completion = {
          documentation = {
            auto_show = true,
          },

          trigger = {
            show_on_keyword = true,
            show_in_snippet = false,
          },

          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end,
          },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },
  },
}
