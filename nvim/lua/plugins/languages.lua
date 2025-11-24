return {
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },
  {
    "tpope/vim-rails",
    config = function()
      vim.keymap.set("n", "<leader>a", function()
        -- Ask rails.vim for the alternate path
        local ok, alt = pcall(vim.api.nvim_eval, "rails#buffer().alternate()")
        if not ok or alt == nil or alt == "" then
          vim.notify("rails.vim: no alternate file for this buffer", vim.log.levels.WARN)
          return
        end

        -- If it already exists, just edit it
        if vim.fn.filereadable(alt) == 1 then
          vim.cmd("edit " .. vim.fn.fnameescape(alt))
          return
        end

        -- Otherwise, create parent dirs and then edit the new file
        local dir = vim.fn.fnamemodify(alt, ":h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
          vim.fn.mkdir(dir, "p")
        end

        vim.cmd("edit " .. vim.fn.fnameescape(alt))
      end, { desc = "Switch between test and implementation (create if missing)" })
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
