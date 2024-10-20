nnoremap <c-t> :ToggleTerm direction=horizontal<cr>
nnoremap <m-t> :ToggleTerm direction=float<cr>
" nnoremap <leader>tt :ToggleTerm direction=tab<cr>
tnoremap <esc><esc> <c-\><c-n>:ToggleTerm<cr>

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
