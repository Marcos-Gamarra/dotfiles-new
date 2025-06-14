local function yazi()
    local servername = vim.api.nvim_get_vvar('servername')
    local command = { "alacritty", "-T", "Yazi", "-e", "yazi" }
    vim.system(command, {
        env = {
            YAZI_EDITOR = "nvim --server " .. servername .. " --remote",
        },
    })
end

vim.api.nvim_create_user_command("Yazi", yazi, { desc = "Open terminal to use yazi on it" })
