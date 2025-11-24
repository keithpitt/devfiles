vim.diagnostic.config({
  severity_sort = true,

  float = {
    border = "rounded",
    source = "if_many",
  },

  underline = {
    severity = vim.diagnostic.severity.WARN,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },

  -- virtual_text = {
  --   source = "if_many",
  --   spacing = 2,
  --   format = function(diagnostic)
  --     local diagnostic_message = {
  --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
  --       [vim.diagnostic.severity.WARN] = diagnostic.message,
  --       [vim.diagnostic.severity.INFO] = diagnostic.message,
  --       [vim.diagnostic.severity.HINT] = diagnostic.message,
  --     }
  --     return diagnostic_message[diagnostic.severity]
  --   end,
  -- },

  -- virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
  -- virtual_lines = { current_line = true, severity = { min = "ERROR" } },
  --
  virtual_lines = {
    source = "if_many",
    current_line = true,
    -- spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },

  inlay_hints = {
    enabled = true,
  },

  codelens = {
    enabled = false,
  },
})
