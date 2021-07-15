vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd nvim-compe]]

local lspconfig = require "lspconfig"

-- TODO: Add toggle for virtual_text
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            underline = true,
            update_in_insert = false,
            virtual_text = false,
            signs = true,
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

-- https://github.com/theia-ide/typescript-language-server
lspconfig.tsserver.setup {
 on_attach = function(client, bufnr)
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "single"
    }
  })
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

-- https://github.com/iamcco/vim-language-server
lspconfig.vuels.setup {
    on_attach = on_attach
}

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

vim.g.neoformat_javascriptreact_eslint_d = {
  exe = 'eslint_d',
  args = {'--stdin', '--stdin-filename', '"%:p"', '--fix-to-stdout'},
  stdin = 1
}

vim.g.neoformat_typescriptreact_eslint_d = {
  exe = 'eslint_d',
  args = {'--stdin', '--stdin-filename', '"%:p"', '--fix-to-stdout'},
  stdin = 1
}

vim.g.neoformat_vue_eslint_d = {
  exe = 'eslint_d',
  args = {'--stdin', '--stdin-filename', '"%:p"', '--fix-to-stdout'},
  stdin = 1
}

vim.g.neoformat_enabled_javascript = {'prettier', 'eslint_d'}
vim.g.neoformat_enabled_typescript = {'prettier', 'eslint_d'}
vim.g.neoformat_enabled_javascriptreact = {'prettier', 'eslint_d'}
vim.g.neoformat_enabled_typescriptreact = {'prettier', 'eslint_d'}
vim.g.neoformat_enabled_vue = {'prettier', 'eslint_d'}

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

