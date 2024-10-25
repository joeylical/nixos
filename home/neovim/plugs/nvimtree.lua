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

local function is_nvim_tree_open()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value("filetype", {
            buf = buf
        })
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
            vim.defer_fn(function()
                vim.cmd('quitall')
            end, 100)
            -- these codes do not work
            vim.cmd('quitall')
            print('NOT EXIT!')
        end
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.tbl_isempty(vim.tbl_filter(function(win)
            return vim.fn.getbufvar(vim.fn.winbufnr(win), "&bt") == ""
        end, vim.fn.range(1, vim.fn.winnr('$')))) then
            vim.cmd('qa!')
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

