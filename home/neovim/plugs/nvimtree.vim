map <F3> :NvimTreeToggle<CR>

function Start_ntree_toggle()
    if isdirectory("./.git") || argc() == 0
        execute "NvimTreeOpen"
        execute "wincmd p"
    endif
endfunction

autocmd VimEnter * call Start_ntree_toggle()

let g:togglenvimtree = 0

function! ToggleNTree()
    if bufexists(bufnr('NvimTree'))
        let g:togglenvimtree = 1
    endif
    execute "NvimTreeToggle"
endfunction

function! CloseNvimOnNvimTreeClose()
    if g:togglenvimtree == 1
        g:togglenvimtree = 0
    else
        qall
    endif
endfunction

" 将函数绑定到 NvimTree 的关闭事件
" autocmd! FileType NvimTree autocmd WinLeave <buffer> call CloseNvimOnNvimTreeClose()

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
        },
        git = {
            enable = true,
        },
    })
EOF

