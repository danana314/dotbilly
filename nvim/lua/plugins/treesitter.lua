local ts = require('nvim-treesitter')

ts.setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

local parsers = {
  'go', 'gomod', 'gosum', 'gowork',
  'html', 'css',
  'markdown', 'markdown_inline',
  'lua', 'vimdoc', 'bash', 'json', 'yaml',
}

-- install any missing parsers (no-op, fast, if already installed)
ts.install(parsers):wait(300000)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gosum', 'gowork', 'html', 'css', 'markdown', 'lua', 'help', 'sh', 'json', 'yaml' },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
