map <F3> :NvimTreeToggle<CR>

function Start_ntree_toggle()
    if isdirectory("./.git") || argc() == 0
        execute "NvimTreeOpen"
        execute "wincmd p"
    endif
endfunction

autocmd VimEnter * call Start_ntree_toggle()

lua <<EOF
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        filters = {
            dotfiles = true,
        },
    })
EOF

