vim.keymap.set('n', '<m-/>', ':CommentToggle<cr>')
vim.keymap.set('v', '<m-/>', ':\'<,\'>CommentToggle<cr>')
require('nvim_comment').setup({
    hook = function()
        if vim.api.nvim_buf_get_option(0, "filetype") == "nix" then
            vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
        end
        if vim.api.nvim_buf_get_option(0, "filetype") == "sql" then
            vim.api.nvim_buf_set_option(0, "commentstring", "-- %s")
        end
    end
})
