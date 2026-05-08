return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ensure_installed = { "ruby", "html", "graphql", "embedded_template" }

      require("nvim-treesitter").install(ensure_installed)

      -- Map parsers → filetypes that should get treesitter highlighting/indent.
      -- `embedded_template` is the parser; the filetype is `eruby`.
      local filetypes = { "ruby", "html", "graphql", "eruby" }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          -- Treesitter highlighting
          pcall(vim.treesitter.start, args.buf)

          -- Treesitter-based indent
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Keep vim's regex highlighting on for Ruby (your old
          -- additional_vim_regex_highlighting = { "ruby" } setting)
          if vim.bo[args.buf].filetype == "ruby" then
            vim.bo[args.buf].syntax = "ON"
          end
        end,
      })
    end,
  },
}
