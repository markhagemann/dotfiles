local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { -- Automatically install LSPs and related tools to stdpath for Neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "askfiy/lsp_extra_dim",
      config = function()
        require("lsp_extra_dim").setup()
      end,
    },
    "hrsh7th/cmp-nvim-lsp", -- LSP completion
    { "Bilal2453/luvit-meta", lazy = true },
    -- { -- optional completion source for require statements and module annotations
    --   "hrsh7th/nvim-cmp",
    --   opts = function(_, opts)
    --     opts.sources = opts.sources or {}
    --     table.insert(opts.sources, {
    --       name = "lazydev",
    --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    --     })
    --   end,
    -- },
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
          "luvit-meta/library",
        },
      },
    },
    {
      "simrat39/symbols-outline.nvim",
      keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "[S]ymbols [O]utline" } },
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
    },
    { "Zeioth/garbage-day.nvim" },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>td", require("telescope.builtin").lsp_type_definitions, "[T]ype [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        map("]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Jump to previous diagnostic")
        map(
          "]e",
          "<cmd>lua vim.diagnostic.goto_prev( { severity = { min = vim.diagnostic.severity.ERROR } })<CR>",
          "Jump to previous diagnostic"
        )
        map("[d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Jump to previous diagnostic")
        map(
          "[e",
          "<cmd>lua vim.diagnostic.goto_next( { severity = { min = vim.diagnostic.severity.ERROR } })<CR>",
          "Jump to previous diagnostic"
        )

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
        { "delve" },
        { "eslint_d" },
        { "gitlab_ci_ls" },
        { "gopls" },
        { "html-lsp" },
        { "lua-language-server" },
        { "prettierd" },
        { "stylua" },
        { "tailwindcss-language-server" },
        { "typescript-language-server" },
        { "volar" },
      },

      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })

    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    -- local signs = {
    --   Error = "",
    --   Warn = "",
    --   Hint = " ",
    --   Info = "",
    -- }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
      virtual_text = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    local mason_registry = require("mason-registry")
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
      .. "/node_modules/@vue/language-server"

    local servers = {
      -- pyright = {},
      rust_analyzer = {},
      ts_ls = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
            },
          },
          preferences = {
            -- other preferences...
            importModuleSpecifierPreference = "relative",
            importModuleSpecifierEnding = "minimal",
          },
        },
        -- Used for when hybridMode is enabled
        -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      volar = {
        -- NOTE: Uncomment to enable volar in file types other than vue.
        -- (Similar to Takeover Mode)

        -- filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

        -- NOTE: Uncomment to restrict Volar to only Vue/Nuxt projects. This will enable Volar to work alongside other language servers (tsserver).

        -- root_dir = require("lspconfig").util.root_pattern(
        --   "vue.config.js",
        --   "vue.config.ts",
        --   "nuxt.config.js",
        --   "nuxt.config.ts"
        -- ),
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
        settings = {
          typescript = {
            inlayHints = {
              enumMemberValues = {
                enabled = true,
              },
              functionLikeReturnTypes = {
                enabled = true,
              },
              propertyDeclarationTypes = {
                enabled = true,
              },
              parameterTypes = {
                enabled = true,
                suppressWhenArgumentMatchesName = true,
              },
              variableTypes = {
                enabled = true,
              },
            },
          },
        },
      },
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