require('bufferline').setup({
    options = {
        mode = "buffers",
        number = "ordinal",
        close_command = require('bufdelete').bufdelete,
        indicator = {
            style = 'underline'
        },
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "Files",
                text_align = "center",
                separator = true
            }
        }
    }
})
