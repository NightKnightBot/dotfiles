-- Plugins
vim.pack.add {
  {
    src = 'https://github.com/lewis6991/gitsigns.nvim',
    name = 'gitsigns'
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    name = 'treesitter'
  },
  {
    src = 'https://github.com/neovim-treesitter/treesitter-parser-registry',
    name = 'treesitter-registry'
  },
  {
    src = 'https://github.com/OXY2DEV/markview.nvim',
    name = 'markview'
  },
  {
    src = 'https://github.com/nvim-mini/mini.surround',
    name = 'surround'
  },
  {
    src = 'https://github.com/nvim-mini/mini.ai',
    name = 'ai (around)'
  },
  {
    src = 'https://github.com/nvim-mini/mini.move',
    name = 'move'
  },
  {
    src = 'https://github.com/nvim-mini/mini.files',
    name = 'files'
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
    name = 'treesitter-context'
  },
  {
    src = 'https://github.com/echasnovski/mini.pick',
    name = 'Picker'
  },
  {
    src = 'https://github.com/HakonHarnes/img-clip.nvim',
    name = 'image-clip'
  },
  {
    src = 'https://github.com/akinsho/toggleterm.nvim',
    name = 'toggleterm'
  },
  {
    src = 'https://github.com/jghauser/follow-md-links.nvim',
    name = 'follow-markdown-links'
  },
  {
    src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
    name = 'tiny-inline-diagnostic'
  },
  {
    src = 'https://github.com/nanotee/zoxide.vim',
    name = 'zoxide'
  },
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
    name = 'lspconfig'
  },
  {
    src = 'https://github.com/amitds1997/remote-nvim.nvim',
    name = 'remote'
  },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
}

require('mini.surround').setup()
require('mini.ai').setup()
require('mini.pick').setup()
require('mini.move').setup()
require('mini.files').setup()
require('tiny-inline-diagnostic').setup()
require('toggleterm').setup()
require('gitsigns').setup()
require('remote-nvim').setup()
require 'treesitter-context'.setup { enable = true }
