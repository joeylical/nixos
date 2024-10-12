" Find files using Telescope command-line sugar.
nnoremap <m-f> :Telescope live_grep<CR>
" nnoremap <s-f> :Telescope grep_string<CR>

lua <<EOF
    require('telescope').setup()
EOF

