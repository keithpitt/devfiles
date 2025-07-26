return {
  {
    "stevearc/conform.nvim",
    config = function()
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
        },
      })
    end,
  },
}
