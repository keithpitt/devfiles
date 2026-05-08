return {
  -- root_markers = { "Gemfile", ".git" },

  cmd = { "mise", "exec", "--", "ruby-lsp" },

  init_options = {
    formatter = "auto",
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
