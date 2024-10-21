require('bufferline').setup({
    options = {
        mode = "buffers",
        number = "ordinal",
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
