local function strip_quotes(str)
  if str then
    return str:gsub('^"(.*)"$', '%1')
  end
  return str
end

return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "zenbones"
    end,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "night-owl"
    end,
  },
  {
    "yorumicolors/yorumi.nvim",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "yorumi"
    end,
  },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "ayu"
    end,
    config = function()
      require('ayu').setup({
        -- mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
        -- terminal = true, -- Set to `false` to let terminal manage its own colors.
        -- overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
      })
    end
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "kanagawa"
    end,
    config = function()
      require("kanagawa").setup({
        theme = "wave",
        overrides = function(colors)
          local theme = colors.theme

          local makeDiagnosticColor = function(color)
            local c = require("kanagawa.lib.color")
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end

          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
          }
        end,
      })
    end,
  },
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "jellybeans"
    end,
    opts = {
      italics = false,
    },
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "catppuccin"
    end,
  },
  {
    "pineapplegiant/spaceduck",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "spaceduck"
    end,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    cond = function()
      return strip_quotes(os.getenv("NEOVIM_THEME")) == "material"
    end,
    config = function()
      require('material').setup({
        contrast = {
          terminal = false,
          sidebars = false,
          floating_windows = false,
          cursor_line = false,
          lsp_virtual_text = false,
          non_current_windows = false,
          filetypes = {},
        },
        styles = {
          comments = { italic = true },
          strings = {},
          keywords = {},
          functions = {},
          variables = {},
          operators = {},
          types = {},
        },
        plugins = {
          "nvim-treesitter",
          "nvim-web-devicons",
        },
        disable = {
          colored_cursor = false,
          borders = false,
          background = false,
          term_colors = false,
          eob_lines = false,
        },
        high_visibility = {
          lighter = false,
          darker = false,
        },
        lualine_style = "default",
        async_loading = true,
        custom_colors = nil,
        custom_highlights = {},
      })
      vim.g.material_style = "deep ocean"
    end
  },
}
