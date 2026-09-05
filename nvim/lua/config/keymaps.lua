local map = vim.keymap.set

-- clear search highlight
map('n', '<leader><space>', '<cmd>nohlsearch<cr>:call clearmatches()<cr>')

-- buffers
map('n', '<leader>ba', '<cmd>bufdo bd<cr>', { desc = 'Close all buffers' })
map('n', '<leader>q', '<cmd>bd<cr>', { desc = 'Delete buffer' })
map('n', '<C-l>', '<cmd>bnext<cr>')
map('n', '<C-h>', '<cmd>bprevious<cr>')

-- system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>p', '"+p')

-- prevent accidental :q from exiting nvim entirely (use :close instead,
-- :qa still works when you actually mean to quit)
vim.cmd([[cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>]])

-- nnn file picker: opens in a floating terminal at the current file's
-- directory; files picked with <space> (then q to quit) are opened as
-- buffers, first one in the current window and the rest loaded in background
local function open_nnn()
  local picker_file = vim.fn.tempname()
  local dir = vim.fn.expand('%:p:h')
  if dir == '' then
    dir = vim.fn.getcwd()
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.termopen(string.format('nnn -p %s', vim.fn.shellescape(picker_file)), {
    cwd = dir,
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end

      local ok, picked = pcall(vim.fn.readfile, picker_file)
      if ok then
        for i, path in ipairs(picked) do
          if path ~= '' then
            vim.cmd((i == 1 and 'edit ' or 'badd ') .. vim.fn.fnameescape(path))
          end
        end
      end
      vim.fn.delete(picker_file)
    end,
  })
  vim.cmd.startinsert()
end

map('n', '<leader>n', open_nnn, { desc = 'Open nnn file picker' })
