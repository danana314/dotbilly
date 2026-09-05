vim.pack.add({
  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.0') },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
})

require('plugins.colorscheme')
require('plugins.treesitter')
require('plugins.completion')
require('plugins.lsp')
require('plugins.telescope')
require('plugins.statusline')
require('plugins.git')
require('plugins.markdown')
