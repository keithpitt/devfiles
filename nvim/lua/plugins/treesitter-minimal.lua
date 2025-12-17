return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = { "BufReadPost *.rb", "BufNewFile *.rb" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "ruby", "html", "graphql", "embedded_template" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      -- injections = {
      --   enable = true,
      -- },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
