" Color Scheme
set background=dark
set t_ut=
set termguicolors
colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1

" Editor
set encoding=utf-8 fileencoding=utf-8 nobomb  " Use UTF-8 without BOM.
set expandtab softtabstop=2  " <Tab> inserts 2 spaces.
set tabstop=2  " Make tabs as wide as 2 spaces.
set shiftwidth=2  " Make indentations as wide as 2 spaces.
set smartindent  " Enable smart indentation.
set list listchars=tab:>-,trail:-,eol:\ ,extends:>,precedes:<,nbsp:_  " Show invisible characters.
set whichwrap=b,s,\<,\>,[,]
set virtualedit=onemore
set wildmode=list:longest  " Select the completion type in the command line.
nnoremap j gj
nnoremap k gk
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
autocmd BufWritePre * :%s/\s\+$//ge  " Automatically delete spaces at line end.
"set mouse=a
"set clipboard=unnamed

" Window
syntax on  " Enable syntax highlighting.
set number  " Enable line numbers.
set cursorline  " Highlight current line.
set showmatch  " Highlight matching braces.
set showmode  " Show the current mode
set showcmd  " Show the (partial) command as it’s being typed
set laststatus=2
set statusline=%<
set statusline+=%f%m%r%h%w
"set statusline+=%{fugitive#statusline()}
set statusline+=%=
set statusline+=%l,%c%{'\ '}
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}
set statusline+=%{'['.&ff.']'}
set statusline+=%y

" Files
set nobackup  " Create no backup files.
set noswapfile  " Create no swap files.
set autoread  " Automatically read the file changed outside of Vim.
set hidden

" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
