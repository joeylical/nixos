nnoremap <c-t> :ToggleTerm<cr>
nnoremap <m-t> :ToggleTerm direction=float<cr>

lua <<EOF
    require('toggleterm').setup()
EOF
