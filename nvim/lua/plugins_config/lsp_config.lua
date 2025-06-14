local borders = {
    { "┏", "FloatBorder" },

    { "━", "FloatBorder" },

    { "┓", "FloatBorder" },

    { "┃", "FloatBorder" },

    { "┛", "FloatBorder" },

    { "━", "FloatBorder" },

    { "┗", "FloatBorder" },

    { "┃", "FloatBorder" },
}

local win = require('lspconfig.ui.windows')
win.default_options.border = borders

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or borders
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.keymap.set('n', 'ly', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', 'lt', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', 'ln', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', 'lq', vim.diagnostic.setloclist, { noremap = true, silent = true })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { noremap = true, silent = true, buffer = ev.buffer }
        vim.keymap.set('n', 'lD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'le', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'lh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'lrn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'lc', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'la', vim.lsp.buf.format, opts)
        vim.keymap.set('n', 'lld', require('telescope.builtin').lsp_implementations, opts)
        vim.keymap.set('n', 'lre', require('telescope.builtin').lsp_references, opts)
        vim.keymap.set('n', 'li', require('telescope.builtin').lsp_incoming_calls, opts)
        vim.keymap.set('n', 'lo', require('telescope.builtin').lsp_outgoing_calls, opts)
        vim.keymap.set('n', 'lb', require('telescope.builtin').lsp_definitions, opts)
        vim.keymap.set('n', 'ld', require('telescope.builtin').diagnostics, opts)
        vim.keymap.set('n', 'llh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
    end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()

require 'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                buildScripts = {
                    enable = true,
                }
            },
        }
    }
}


require 'lspconfig'.pylsp.setup {
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'E501' },
                }
            }
        }
    }
}

require 'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

require 'lspconfig'.ts_ls.setup {
    capabilities = capabilities,
    settings = {
        javascript = {
            format = {
                indentSize = 2,
            },
        },
    }
}

require 'lspconfig'.html.setup {
    capabilities = capabilities,
}

require 'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require 'lspconfig'.tailwindcss.setup {
    capabilities = capabilities,
    filetypes = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
}

require 'lspconfig'.svelte.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        if client.name == "svelte" then
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufWritePre" }, {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                    client:notify("$/onDidChangeTsOrJsFile", {
                        uri = ctx.match,
                    })
                end
            })
        end
    end
}


require 'lspconfig'.clangd.setup {
    capabilities = capabilities,
}


require 'lspconfig'.zls.setup {
    capabilities = capabilities,
}



require('lspconfig').lemminx.setup({
    capabilities = capabilities,
    settings = {
        xml = {
            server = {
                workDir = "~/.cache/lemminx",
            }
        }
    }
})
