local opt = vim.opt

-- we have vcs, we don't need backups or swapfiles
opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.termguicolors = true
opt.mouse = 'nicr'

-- wildmenu / completion ignore
opt.wildignore:append({ '*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store' })

-- search
opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- ...unless the query has uppercase letters
opt.showmatch = true
opt.hlsearch = true
opt.gdefault = true -- use the `g` flag on :s by default

-- windows / buffers
opt.splitbelow = true
opt.splitright = true
opt.hidden = true
opt.autoread = true

-- editor
opt.foldenable = false
opt.wrap = false
opt.autoindent = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.list = true
opt.listchars:append({ nbsp = '‗' })
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Go uses real tabs, not spaces
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})
