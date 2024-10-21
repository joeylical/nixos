vim.keymap.set('n', '<c-t>', ':ToggleTerm direction=horizontal<cr>')
vim.keymap.set('n', '<m-t>', ':ToggleTerm direction=float<cr>')
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>:ToggleTerm<cr>')

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
