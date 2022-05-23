local utils = require "utils"
local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

-- Floating border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or { { " ", "FloatBorder" } }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Gutter sign icons
for type, icon in pairs(utils.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Prefix diagnostic virtual text
vim.diagnostic.config {
    virtual_text = {
        source = "always",
        prefix = " ",
        spacing = 6,
    },
    float = {
        header = false,
        source = "always",
    },
    signs = true,
    underline = false,
    update_in_insert = false,
}
