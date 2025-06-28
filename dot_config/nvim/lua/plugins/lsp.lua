return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { -- Automatically install LSPs and related tools to stdpath for Neovim
    -- "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "askfiy/lsp_extra_dim",
      config = function()
        require("lsp_extra_dim").setup()
      end,
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
      "dmmulroy/ts-error-translator.nvim",
      config = function()
        require("ts-error-translator").setup()
      end,
    },
    {
      "Fildo7525/pretty_hover",
      opts = {},
    },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          "lazy.nvim",
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        require("nvim-lightbulb").setup({
          sign = {
            enabled = true,
            -- Text to show in the sign column.
            -- Must be between 1-2 characters.
            text = "󰌶 ",
            lens_text = "🔎",
            -- Highlight group to highlight the sign column text.
            hl = "LightBulbSign",
          },
        })
      end,
    },
    {
      "rachartier/tiny-code-action.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },

        -- optional picker via telescope
        { "nvim-telescope/telescope.nvim" },
        -- optional picker via fzf-lua
        { "ibhagwan/fzf-lua" },
        -- .. or via snacks
        {
          "folke/snacks.nvim",
          opts = {
            terminal = {},
          },
        },
      },
      event = "LspAttach",
      opts = {},
    },
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "LspAttach",
      priority = 1000, -- needs to be loaded in first
      config = function()
        require("tiny-inline-diagnostic").setup({
          preset = "modern",
          options = { show_source = true, virt_texts = { priority = 5000 } },
        })
      end,
    },
    {
      "simrat39/symbols-outline.nvim",
      keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "symbols outline" } },
      opts = {
        keymaps = {
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          focus_location = "f",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "c",
          unfold = "o",
          fold_all = "C",
          unfold_all = "O",
          fold_reset = "R",
        },
      },
      config = function(_, opts)
        require("symbols-outline").setup(opts)
      end,
    },
    {
      "soulis-1256/eagle.nvim",
      config = function()
        require("eagle").setup({
          keyboard_mode = false,
        })

        vim.keymap.set("n", "<Tab>", ":EagleWin<CR>", { noremap = true, silent = true })
      end,
    },
    { "Zeioth/garbage-day.nvim" },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- Override neovim 0.11 bindings
        pcall(vim.keymap.del, "n", "gra")
        pcall(vim.keymap.del, "n", "gri")
        pcall(vim.keymap.del, "n", "grn")
        pcall(vim.keymap.del, "n", "grr")

        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "lsp: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", function()
          Snacks.picker.lsp_definitions()
        end, "goto definition")

        -- Find references for the word under your cursor.
        map("gr", function()
          Snacks.picker.lsp_references()
        end, "goto references")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gi", function()
          Snacks.picker.lsp_implementations()
        end, "goto implementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>td", function()
          Snacks.picker.lsp_type_definitions()
        end, "type definition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", function()
          Snacks.picker.lsp_document_symbols()
        end, "document symbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>ws", function()
          Snacks.picker.lsp_dynamic_workspace_symbols()
        end, "workspace symbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "rename")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "code action")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map("K", vim.lsp.buf.hover, "hover documentation")
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "goto Declaration")

        -- diagnostic
        local diagnostic_goto = function(next, severity)
          local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
          severity = severity and vim.diagnostic.severity[severity] or nil
          return function()
            go({ severity = severity, float = false })
          end
        end
        map("<leader>cd", vim.diagnostic.open_float, "current diagnostics")
        map("]d", diagnostic_goto(true), "next diagnostic")
        map("[d", diagnostic_goto(false), "prev diagnostic")
        map("]e", diagnostic_goto(true, "ERROR"), "next error")
        map("[e", diagnostic_goto(false, "ERROR"), "prev error")
        map("]w", diagnostic_goto(true, "WARN"), "next warning")
        map("[w", diagnostic_goto(false, "WARN"), "prev warning")

        -- map("]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Jump to previous diagnostic")
        -- map(
        --   "]e",
        --   "<cmd>lua vim.diagnostic.goto_prev( { severity = { min = vim.diagnostic.severity.ERROR } })<CR>",
        --   "Jump to previous diagnostic"
        -- )
        -- map("[d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Jump to previous diagnostic")
        -- map(
        --   "[e",
        --   "<cmd>lua vim.diagnostic.goto_next( { severity = { min = vim.diagnostic.severity.ERROR } })<CR>",
        --   "Jump to previous diagnostic"
        -- )

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = {
        { "bash-language-server" },
        { "css-lsp" },
        { "emmet-ls" },
        -- { "eslint_d" },
        { "eslint-lsp" },
        { "gitlab-ci-ls" },
        { "gopls" },
        { "goimports" },
        { "gomodifytags" },
        { "gotests" },
        { "html-lsp" },
        { "lua-language-server" },
        { "prettierd" },
        { "staticcheck" },
        { "stylua" },
        { "tailwindcss-language-server" },
        -- { "typescript-language-server" },
        { "vtsls" },
        { "vue-language-server" },
      },

      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })

    vim.diagnostic.config({
      virtual_text = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    local mason_registry = require("mason-registry")
    local vue_language_server_path =
      vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")

    vim.lsp.config.vtsls = {
      cmd = { "vtsls", "--stdio" },
      filetypes = {
        "vue",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root_markers = {
        "tsconfig.json",
        "package.json",
        "jsconfig.json",
        ".git",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          tsserver = {
            globalPlugins = {
              {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
        },
      },
    }
    vim.lsp.enable("vtsls", true)

    local servers = {
      -- pyright = {},
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      },
      rust_analyzer = {},
      yaml = {
        schemas = {
          kubernetes = "k8s-*.yaml",
          ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
          ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
            "ci/**/*.yml",
            ".gitlab-ci.yml",
          },
        },
      },
    }

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
