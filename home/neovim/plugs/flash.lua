require('flash').setup({
    search = {
        multi_window = false,
        -- forward = true,
        wrap = false
    },
    modes = {
        char = {
            jump_labels = true,
            keys = { "f", "F", "t", "T" }
        }
    }
})
