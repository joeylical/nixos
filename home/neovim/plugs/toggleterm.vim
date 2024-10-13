nnoremap <c-t> :ToggleTerm<cr>
nnoremap <m-t> :ToggleTerm direction=float<cr>
tnoremap <ESC><ESC> <c-\><c-n>
" tnoremap <c-h> :wincmd h<cr>
" tnoremap <c-j> :wincmd j<cr>
" tnoremap <c-k> :wincmd k<cr>
" tnoremap <c-l> :wincmd l<cr>

lua <<EOF
    require('toggleterm').setup({
        float_opts = {
            border = 'rounded'
        }
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd="lazygit", hidden=true, direction="float"});
    function _lazygit_toggle()
        lazygit:toggle()
    end
EOF
