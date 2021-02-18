local lspconfig = require "lspconfig"

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.cmd [[noautocmd :update]]
            vim.cmd [[GitGutter]]
        end
    end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            underline = true,
            update_in_insert = false,
            virtual_text = false
        }
    )(...)
    pcall(vim.lsp.diagnostic.set_loclist, {open_loclist = false})
end

vim.lsp.protocol.CompletionItemKind = {
    " [text]",
    "坿 [method]",
    "ル [function]",
    "汹 [constructor]",
    "ﰠ [field]",
    " [variable]",
    " [class]",
    "瀬 [interface]",
    " [module]",
    " [property]",
    "撴 [unit]",
    " [value]",
    " [enum]",
    " [key]",
    "﬌ [snippet]",
    "凇 [color]",
    " [file]",
    "⻖ [reference]",
    " [folder]",
    " [enum member]",
    "沜 [constant]",
    " [struct]",
    "⌘ [event]",
    " [operator]",
    "♛ [type]"
}

vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})

require "compe".setup {
    enabled = true,
    debug = false,
    autocomplete = false,
    min_length = 1,
    preselect = "disable",
    allow_prefix_unmatch = false,
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
        nvim_lua = true,
        ultisnips = true
    }
}

local on_attach = function(client)
    if client.resolved_capabilities.code_action then
        vim.cmd [[augroup CodeAction]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()]]
        vim.cmd [[augroup END]]
    end
    -- if client.resolved_capabilities.document_formatting then
    --     vim.cmd [[augroup Format]]
    --     vim.cmd [[autocmd! * <buffer>]]
    --     vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
    --     vim.cmd [[augroup END]]
    -- end
    if client.resolved_capabilities.goto_definition then
        map("n", "td", "<cmd>lua vim.lsp.buf.definition()<CR>")
    end
    if client.resolved_capabilities.completion then
        map("i", "<C-Space>", "compe#complete()", true, true)
        map("i", "<CR>", "compe#confirm(lexima#expand('<LT>CR>', 'i'))", true, true)
        map("i", "<C-e>", "compe#close('<C-e>')", true, true)
    end
    if client.resolved_capabilities.hover then
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    end
    if client.resolved_capabilities.find_references then
        map("n", "tr", ":call lists#ChangeActiveList('Quickfix')<CR>:lua vim.lsp.buf.references()<CR>")
    end
    if client.resolved_capabilities.rename then
        map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
    end
end

function _G.activeLSP()
    local servers = {}
    for _, lsp in pairs(vim.lsp.get_active_clients()) do
        table.insert(servers, {name = lsp.name, id = lsp.id})
    end
    _G.dump(servers)
end
function _G.bufferActiveLSP()
    local servers = {}
    for _, lsp in pairs(vim.lsp.buf_get_clients()) do
        table.insert(servers, {name = lsp.name, id = lsp.id})
    end
    _G.dump(servers)
end

-- https://github.com/theia-ide/typescript-language-server
lspconfig.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

local function get_lua_runtime()
    local result = {}
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/"
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true
    result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

    return result
end
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            completion = {
                keywordSnippet = "Disable"
            },
            diagnostics = {
                enable = true,
                globals = {
                    -- Neovim
                    "vim",
                    -- Busted
                    "describe",
                    "it",
                    "before_each",
                    "after_each",
                    "teardown",
                    "pending"
                },
                workspace = {
                    library = get_lua_runtime(),
                    maxPreload = 1000,
                    preloadFileSize = 1000
                }
            }
        }
    }
}

-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup {on_attach = on_attach}

-- https://github.com/vscode-langservers/vscode-json-languageserver
lspconfig.jsonls.setup {
    on_attach = on_attach,
    cmd = {"json-languageserver", "--stdio"}
}

-- https://github.com/redhat-developer/yaml-language-server
lspconfig.yamlls.setup {on_attach = on_attach}

-- https://github.com/joe-re/sql-language-server
lspconfig.sqlls.setup {on_attach = on_attach}

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
lspconfig.cssls.setup {on_attach = on_attach}

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
lspconfig.html.setup {on_attach = on_attach}

-- https://github.com/bash-lsp/bash-language-server
lspconfig.bashls.setup {on_attach = on_attach}

-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
lspconfig.dockerls.setup {on_attach = on_attach}

local vint = require "efm/vint"
local luafmt = require "efm/luafmt"
local golint = require "efm/golint"
local goimports = require "efm/goimports"
local black = require "efm/black"
local isort = require "efm/isort"
local flake8 = require "efm/flake8"
local mypy = require "efm/mypy"
local prettier = require "efm/prettier"
local eslint = require "efm/eslint"
local shellcheck = require "efm/shellcheck"
local terraform = require "efm/terraform"
local misspell = require "efm/misspell"

-- https://github.com/mattn/efm-langserver
lspconfig.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            ["="] = {misspell},
            vim = {vint},
            lua = {luafmt},
            go = {golint, goimports},
            python = {black, isort, flake8, mypy},
            vue = {prettier, eslint},
            typescript = {prettier, eslint},
            javascript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier},
            sh = {shellcheck},
            tf = {terraform}
        }
    }
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

