" Find files using Telescope command-line sugar.
" nnoremap <m-f> :Telescope live_grep<CR>

lua <<EOF
    require('telescope').setup()
EOF

