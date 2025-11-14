return {
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },
  {
    "tpope/vim-rails",
  },
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>t", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
      { "<leader>T", "<cmd>TestFile<CR>", desc = "Run test file" },
      { "<leader>rr", "<cmd>TestFile<CR>", desc = "Run test file" },
      { "<leader>a", "<cmd>TestSuite<CR>", desc = "Run test suite" },
      { "<leader>l", "<cmd>TestLast<CR>", desc = "Run last test" },
      { "<leader>g", "<cmd>TestVisit<CR>", desc = "Go to test file" },
    },
  },
  {
    "overleaf/vim-env-syntax",
    ft = "env",
  },
}
