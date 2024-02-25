nnoremap <m-/> :CommentToggle<CR>
vnoremap <m-/> :'<,'>CommentToggle<CR>

lua <<EOF
    require('nvim_comment').setup({
        hook = function()
            if vim.api.nvim_buf_get_option(0, "filetype") == "nix" then
                vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
            end
        end
    })
EOF
