set number
" set cc=120
set textwidth=100

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

autocmd FileType nix setlocal ts=2 sw=2
autocmd FileType html setlocal ts=2 sw=2
autocmd FileType css setlocal ts=2 sw=2
autocmd FileType javascript setlocal ts=2 sw=2

set incsearch
set nohlsearch
set ignorecase
set smartcase

set nobackup
set noswapfile
set autoread
set confirm
set wildmenu
set completeopt-=preview
set showcmd

set mouse=a

set cursorline

let g:mapleader = ","

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <m-j> 5jzz
nnoremap <m-k> 5kzz
nnoremap <m-h> :bp<cr>
nnoremap <m-l> :bn<cr>

imap <c-v> <esc>p
map <c-a> <esc><esc>ggVG


function Close_cur_buf()
    if 1 == len(getbufinfo({'buflisted':1}))
        execute "enew"
        execute "bd #"
    else
        execute "bn"
        execute "bd #"
    endif
endfunction

nnoremap <m-w> :call Close_cur_buf()<cr>
nnoremap <c-w> :close<cr>

" nnoremap <c-up> :resize -2<cr>
" nnoremap <c-down> :resize +2<cr>
" nnoremap <c-left> :vertical resize +2<cr>
" nnoremap <c-right> :vertical resize -2<cr>

autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif


" set foldmethod=indent
" set foldlevel=99
" nnoremap <space> za

" colorscheme gruvbox
" colorscheme tokyonight-day
" colorscheme one
function SetMode(dark)
    if a:dark == v:true
        colorscheme material-deep-ocean
        set background=dark
    else
        colorscheme material-lighter
        set background=light
    endif
endfunction

function AutoSetMode()
    if filereadable(glob('$HOME/.darkmode'))
        let darkmode = readfile(glob('$HOME/.darkmode'))
        if darkmode[0] == 'dark'
            call SetMode(v:true)
        else
            call SetMode(v:false)
        endif
    else
        call SetMode(v:true)
    endif
endfunction

call AutoSetMode()

autocmd Signal SIGUSR1 call AutoSetMode()

" nnoremap <leader>b  :colorscheme tokyonight<cr>
" nnoremap <leader>w  :execute "colorscheme " + dark_schema-day<cr>
" nnoremap <leader>b  :colorscheme material-darker<cr>
" nnoremap <leader>b  :colorscheme morning<cr>
" nnoremap <leader>b  :set background=dark<cr>
" nnoremap <leader>w  :set background=light<cr>
nnoremap <leader>b  :call SetMode(v:true)<cr>
nnoremap <leader>w  :call SetMode(v:false)<cr>


set guifont=CaskaydiaCove\ NFM:h12
let g:neovide_cursor_animation_length = 0
let g:neovide_remember_window_size = v:true

nnoremap <leader>1 :BufferLineGoToBuffer 1<CR>
nnoremap <leader>2 :BufferLineGoToBuffer 2<CR>
nnoremap <leader>3 :BufferLineGoToBuffer 3<CR>
nnoremap <leader>4 :BufferLineGoToBuffer 4<CR>
nnoremap <leader>5 :BufferLineGoToBuffer 5<CR>
nnoremap <leader>6 :BufferLineGoToBuffer 6<CR>
nnoremap <leader>7 :BufferLineGoToBuffer 7<CR>
nnoremap <leader>8 :BufferLineGoToBuffer 8<CR>
nnoremap <leader>9 :BufferLineGoToBuffer 9<CR>

" vimrc loader
if filereadable("./vimrc")
    runtime ./vimrc
endif
if filereadable("./vimrc.lua")
    runtime ./vimrc.lua
endif
