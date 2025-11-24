return {
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },
  {
    "tpope/vim-rails",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>`",
        "<cmd>A<CR>",
        { desc = "Switch between spec and implementation" }
      )
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      -- { "<leader>t", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
      -- { "<leader>T", "<cmd>TestFile<CR>", desc = "Run test file" },
      -- { "<leader>rr", "<cmd>TestFile<CR>", desc = "Run test file" },
      -- { "<leader>a", "<cmd>TestSuite<CR>", desc = "Run test suite" },
      -- { "<leader>l", "<cmd>TestLast<CR>", desc = "Run last test" },
      -- { "<leader>g", "<cmd>TestVisit<CR>", desc = "Go to test file" },
      vim.keymap.set("n", "rr", "<cmd>TestFile<CR>", { desc = "Run test file" })
    end,
  },
  {
    "overleaf/vim-env-syntax",
    ft = "env",
  },
}
