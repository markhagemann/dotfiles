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
      "stevearc/aerial.nvim",
      keys = {
        { "<leader>ta", "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
      },
      opts = {
        close_automatic_events = {
          "unfocus",
          "switch_buffer",
        },
        guides = {
          nested_top = " │ ",
          mid_item = " ├─",
          last_item = " └─",
          whitespace = "   ",
        },
        layout = {
          placement = "window",
          close_on_select = false,
          max_width = 30,
          min_width = 30,
        },
        ignore = {
          buftypes = {},
        },
        show_guides = true,
        open_automatic = false,
        -- open_automatic = function()
        --   local aerial = require("aerial")
        --   return vim.api.nvim_win_get_width(0) > 80 and not aerial.was_closed()
        -- end,
      },
      config = function(_, opts)
        require("aerial").setup(opts)
      end,
    },
    -- {
    --   "simrat39/symbols-outline.nvim",
    --   keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Symbols outline" } },
    --   opts = {
    --     keymaps = {
    --       close = { "<Esc>", "q" },
    --       goto_location = "<Cr>",
    --       focus_location = "f",
    --       hover_symbol = "<C-space>",
    --       toggle_preview = "K",
    --       rename_symbol = "r",
    --       code_actions = "a",
    --       fold = "c",
    --       unfold = "o",
    --       fold_all = "C",
    --       unfold_all = "O",
    --       fold_reset = "R",
    --     },
    --   },
    --   config = function(_, opts)
    --     require("symbols-outline").setup(opts)
    --   end,
    -- },
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
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
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
        map("<leader>gtd", function()
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

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has("nvim-0.11") == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
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
        { "eslint_d" },
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

    vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
      config = config or {}
      config.border = "rounded"

      vim.lsp.util.open_floating_preview(result.contents, "markdown", config)
    end

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

    -- Trying out after/lsp/vtsls.lua to resolve this instead
    -- local vue_language_server_path = vim.fn.expand("$MASON/packages")
    --   .. "/vue-language-server"
    --   .. "/node_modules/@vue/language-server"
    -- local vue_plugin = {
    --   name = "@vue/typescript-plugin",
    --   location = vue_language_server_path,
    --   languages = { "vue" },
    --   configNamespace = "typescript",
    -- }
    -- local vtsls_config = {
    --   settings = {
    --     vtsls = {
    --       tsserver = {
    --         globalPlugins = {
    --           vue_plugin,
    --         },
    --       },
    --     },
    --   },
    --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    -- }
    --
    -- local vue_ls_config = {
    --   on_init = function(client)
    --     client.handlers["tsserver/request"] = function(_, result, context)
    --       local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
    --       if #clients == 0 then
    --         vim.notify("Could not find `vtsls` lsp client, `vue_ls` would not work without it.", vim.log.levels.ERROR)
    --         return
    --       end
    --       local ts_client = clients[1]
    --
    --       local param = unpack(result)
    --       local id, command, payload = unpack(param)
    --       ts_client:exec_cmd({
    --         title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
    --         command = "typescript.tsserverRequest",
    --         arguments = {
    --           command,
    --           payload,
    --         },
    --       }, { bufnr = context.bufnr }, function(_, r)
    --         local response_data = { { id, r.body } }
    --         ---@diagnostic disable-next-line: param-type-mismatch
    --         client:notify("tsserver/response", response_data)
    --       end)
    --     end
    --   end,
    -- }
    -- vim.lsp.config("vtsls", vtsls_config)
    -- vim.lsp.config("vue_ls", vue_ls_config)
    -- vim.lsp.enable({ "vtsls", "vue_ls" })

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
