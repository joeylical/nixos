vim.keymap.set('', '<F3>', ':lua ToggleNvimTree()<cr>')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local nvimtree_exit = false
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        if vim.fn.isdirectory("./.git") == 1 or vim.fn.argc() == 0 then
            nvimtree_exit = true
            vim.cmd("NvimTreeOpen")
            vim.cmd("wincmd p")
        end
    end
})

function is_nvim_tree_open()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "NvimTree" then
            return true  -- 如果找到 NvimTree 窗口，返回 true
        end
    end
    return false  -- 没有找到 NvimTree 窗口，返回 false
end

function ToggleNvimTree()
    if is_nvim_tree_open() then
        nvimtree_exit = false
        vim.cmd('NvimTreeClose')
    else
        nvimtree_exit = true
        vim.cmd('NvimTreeOpen')
    end
end

vim.api.nvim_create_autocmd('BufWinLeave', {
    pattern = 'NvimTree*',
    callback = function()
        if nvimtree_exit then
            vim.cmd(':qa')
        end
    end
})

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

