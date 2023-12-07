filetype off        " required

call plug#begin()
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'severin-lemaignan/vim-minimap'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mcchrish/nnn.vim'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-commentary'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }

" Plug 'chrisbra/csv.vim'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
set nobackup      " we have vcs, we don't need backups.
set nowritebackup " we have vcs, we don't need backups.
set noswapfile

let mapleader = ","

set t_Co=256
let &t_ut=''
colorscheme afterglow
set background=dark
hi Normal guibg=NONE ctermbg=NONE
set mouse=nicr

fun! CleanExtraSpaces()    " delete trailing white space on save
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" wildmenu
set wildmenu
set wildignore=*.o,*~,*.pyc    " ignore compiled files
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" search
set ignorecase    " case insensitive search
set smartcase     " If there are uppercase letters, become case-sensitive.
" set incsearch     " live incremental searching
set showmatch     " live match highlighting
set hlsearch      " highlight matches
set gdefault      " use the `g` flag by default.
noremap <leader><space> :noh<cr>:call clearmatches()<cr>    " clear match highlighting

" easier window nav
set splitbelow splitright

" dealing with buffers
set hidden    " allow buffers with unsaved changes.
set autoread  " when a file has changed on disk, just load it. Don't ask.

nnoremap <leader>ba :bufdo bd<cr>    " close all buffers
nnoremap <leader>q :bd<cr>           " delete buffer
nnoremap <C-l> :bnext<cr>
nnoremap <C-h> :bprevious<cr>

cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>    " prevent accidental vim exits

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map 0 ^          " remap 0 to first non-blank character

set nofoldenable
set nowrap

set autoindent   " Match indents on new lines.
set smartindent  " Intellegently dedent / indent new lines based on rules.
set number relativenumber

set list
set listchars+=nbsp:‗

set cursorline

noremap <Leader>y "+y
noremap <Leader>p "+p

" save session
map <Leader>S :mks! ~/.config/nvim/sessions.vim
map <Leader>SS :source ~/.config/nvim/sessions.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin customizations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ctrlp_max_height = 20

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='minimalist'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" nnoremap <Leader>a :Ag<Space>
" nnoremap <Leader>a :Ag <C-R><C-W><CR>

nnoremap <Leader>f :Files<CR>

" let g:startify_lists = [  { 'type': 'dir','header': ['   MRU '.getcwd()]}]
" let g:ranger_map_keys = 0
" map <leader>rw :RangerWorkingDirectory<CR>
" map <leader>rf :Ranger<CR>
