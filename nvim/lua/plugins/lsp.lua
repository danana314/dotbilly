-- broadcast blink.cmp's extra completion capabilities to every server
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable({ 'gopls', 'html', 'cssls' })

-- go-to-definition isn't bound by default (Nvim uses tagfunc + Ctrl-] instead)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: go to definition' })

-- format on save, for any server that supports it
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-format-on-save', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 2000 })
        end,
      })
    end
  end,
})

-- goimports-style import cleanup on save (gopls doesn't do this via plain formatting)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, 'utf-8')
        end
      end
    end
  end,
})
