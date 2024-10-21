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

set signcolumn=yes

set termguicolors

let g:mapleader = ","

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <m-j> 5jzz
nnoremap <m-k> 5kzz
nnoremap <m-h> :bp<cr>
nnoremap <m-l> :bn<cr>

" Emacs key-bindings in insert mode
inoremap <C-a> <esc>^i
inoremap <C-e> <esc>A
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <M-b> <C-o>b
inoremap <M-f> <C-o>w
inoremap <C-w> <Esc>dbcl
inoremap <C-u> <Esc>d0cl
inoremap <C-k> <Esc><Right>C
inoremap <C-d> <Esc><Right>s
inoremap <M-d> <C-o>de

nnoremap <leader>g :lua _lazygit_toggle()<cr>

lua require('which-key').add({{'<leader>f', group='Telescope'}})
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua require('which-key').add({{'<leader>f', group='ToggleTerm'}})
nnoremap <leader>th :ToggleTerm direction=horizontal<cr>
nnoremap <leader>tf :ToggleTerm direction=float<cr>

lua require('which-key').add({{'<leader>f', group='Glance'}})
nnoremap <leader>dr <CMD>Glance references<CR>
nnoremap <leader>dd <CMD>Glance definitions<CR>
nnoremap <leader>dy <CMD>Glance type_definitions<CR>
nnoremap <leader>dm <CMD>Glance implementations<CR>

noremap <F2> :SymbolsOutline<cr>

nnoremap <leader>, :WhichKey<cr>

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
    hi Normal guibg=system("grep -o "[^_]bg_color:[#a-z0-9]*" /etc/profiles/per-user/nixos/share/themes/`grep -o "Flat[a-zA-Z\-]*" ~/.gtkrc-2.0`/gtk-2.0/gtkrc")
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

" vimrc loader
if filereadable("./.vimrc")
    autocmd VimEnter * source ./.vimrc
endif
if filereadable("./.vimrc.lua")
    autocmd VimEnter * source ./.vimrc.lua
endif
