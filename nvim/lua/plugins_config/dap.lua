local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-dap',
    name = 'lldb'
}


dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
}

-- mappings
vim.keymap.set("n", "<space>bb", dap.toggle_breakpoint, { noremap = true, expr = true })
vim.keymap.set("n", "<space>bc", dap.continue, { noremap = true, expr = true })
vim.keymap.set("n", "<space>bso", dap.step_over, { noremap = true, expr = true })
vim.keymap.set("n", "<space>bsi", dap.step_into, { noremap = true, expr = true })
vim.keymap.set("n", "<space>bo", dap.repl.open, {})
