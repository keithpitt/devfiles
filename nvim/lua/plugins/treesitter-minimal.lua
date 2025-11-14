return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost *.rb", "BufNewFile *.rb" },
    opts = {
      ensure_installed = { "ruby", "html" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      injections = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}