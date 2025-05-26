return {
  -- Nicer looking netrw with icons
  -- { 'nvim-tree/nvim-web-devicons', opts = {} },
  -- { 'prichrd/netrw.nvim', opts = {} },

  -- Force background of vim to be transparent
  { 'xiyaowong/transparent.nvim', opts = {} },

  -- Automatically make folders if they don't exist
  { 'jghauser/mkdir.nvim' },

  -- Figure out what the current indentation setup is automatically
  { 'tpope/vim-sleuth' },

  -- Searching across all the files
  { 'duane9/nvim-rg' },

  -- Replacement for netrw
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",

      -- Add image support
      { "3rd/image.nvim", opts = {} },
    },
    -- neo-tree will lazily load itself
    lazy = false,
  },

  -- Best theme ever
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italics = false,
    }
  },

  -- Kinda like ctrl-p
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    }
  },

  -- Removes trailing white space and empty lines at EOF on save
  {
    'mcauley-penney/tidy.nvim',
    config = true,
  },

  -- LSP auto configs
  {
    'neovim/nvim-lspconfig',
  },

  -- Bunch of random cool extras
  {
    'echasnovski/mini.nvim',
    version = '*'
  },
}
