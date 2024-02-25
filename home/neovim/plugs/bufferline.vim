
lua <<EOF
    require('bufferline').setup({
        options = {
            mode = "buffers",
            number = "ordinal",
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "Files",
                    highlight = "Directory",
                    text_align = "left"
                }
            }
        }
    })
EOF
