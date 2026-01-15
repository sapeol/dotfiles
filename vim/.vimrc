" Vim config - minimal but practical

" Basic settings
set nowrap
set number
set relativenumber
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" UI
set termguicolors
set background=dark
set scrolloff=5
set sidescrolloff=5
set laststatus=2
set showmode
set showcmd
set wildmenu
set wildmode=longest:full,full

" Performance
set lazyredraw
set updatetime=300

" Netrw (file browser)
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Key maps - swap colon and semicolon (easier to reach)
nnoremap ; :
nnoremap : ;

" Better j/k in wrapped lines
nnoremap j gj
nnoremap k gk

" Quick save/quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search
nnoremap <leader>/ :nohlsearch<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>d :bdelete<CR>

" Leader key
let mapleader = ","
