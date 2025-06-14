require('blink.cmp').setup({
    completion = {
        menu = {
            border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"
        },
        documentation = {
            window = {
                border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"
            },
        }
    },
    keymap = {
        preset = 'super-tab',
    },
    fuzzy = {
        prebuilt_binaries = {
            download = true,
            force_version = "v0.8.2"
        }
    }
})
