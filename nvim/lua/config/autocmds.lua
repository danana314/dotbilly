-- trim trailing whitespace on save, preserving cursor position and search register
local function clean_extra_spaces()
  local save_cursor = vim.fn.getpos('.')
  local old_query = vim.fn.getreg('/')
  vim.cmd([[keeppatterns silent! %s/\s\+$//e]])
  vim.fn.setpos('.', save_cursor)
  vim.fn.setreg('/', old_query)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go', '*.html', '*.css', '*.js', '*.ts', '*.sh', '*.md', '*.txt' },
  callback = clean_extra_spaces,
})
