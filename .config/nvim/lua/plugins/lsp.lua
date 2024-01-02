local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  -- {
  --   "williamboman/mason.nvim",
  --   cmd = "Mason",
  --   keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  --   config = function()
  --     require("mason").setup()
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = {
  --     auto_install = true,
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --   },
  -- },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Completion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })

      local lsp_zero = require("lsp-zero").preset({
        manage_nvim_cmp = {
          set_sources = "recommended",
          set_basic_mappings = true,
          set_extra_mappings = false,
          use_luasnip = true,
          set_format = true,
          documentation_window = true,
        },
      })

      lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "F2", "<cmd>Lspsaga rename<CR>", opts)
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
        vim.keymap.set("n", "gi", "<cmd>Lspsaga finder imp<CR>", opts)
        vim.keymap.set("n", "gc", "<cmd>Lspsaga go_to_definition<CR>", opts)
        vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
        vim.keymap.set("n", "td", "<cmd>Lspsaga peek_type_definition<CR>", opts)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
        vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
      end)

      lsp_zero.set_sign_icons({
        error = "x",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "tsserver",
          "eslint",
          "tailwindcss",
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      lsp_zero.format_mapping("<leader>lf", {
        format_opts = {
          async = true,
        },
        servers = {
          ["null-ls"] = { "javascript", "typescript", "lua" },
        },
      })

      lsp_zero.format_on_save({
        servers = {
          ["null-ls"] = { "javascript", "typescript", "lua" },
          ["lua_ls"] = { "lua" },
          ["tsserver"] = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        },
      })

      require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
      require("lspconfig").tsserver.setup({
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
      })

      lsp_zero.setup()

      local cmp = require("cmp")
      local cmp_action = require("lsp-zero").cmp_action()

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        preselect = "item",
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
        formatting = {
          fields = { "menu", "abbr", "kind" },

          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = "λ",
              luasnip = "⋗",
              buffer = "Ω",
              path = "/",
              nvim_lua = "Π",
            }

            item.menu = menu_icon[entry.source.name]

            return item
          end,
        },
        mapping = {
          ["<cr>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        },
        sources = {
          { name = "luasnip", keyword_length = 2 },
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer",  keyword_length = 3 },
        },
      })

      -- local cmp = require("cmp")
      -- local luasnip = require("luasnip")
      -- local lspkind = require("lspkind")
      -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
      --
      -- cmp.setup({
      --   sources = {
      --     { name = "path" },
      --     { name = "nvim_lsp" },
      --     { name = "nvim_lua" },
      --     { name = "luasnip", keyword_length = 2 },
      --     { name = "buffer",  keyword_length = 3 },
      --   },
      --   format = lsp_zero.cmp_format(),
      --   -- format = lspkind.cmp_format({
      --   --   maxwidth = 50,
      --   --   ellipsis_char = "...",
      --   -- }),
      --   mapping = cmp.mapping.preset.insert({
      --     ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select), -- previous suggestion
      --     ["<C-j>"] = cmp.mapping.select_next_item(cmp_select), -- next suggestion
      --     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --     ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --     ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      --     ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
      --     -- Accept currently selected item. If none selected, `select` first item.
      --     -- Set `select` to `false` to only confirm explicitly selected items.
      --     ["<CR>"] = cmp.mapping.confirm({ select = true }),
      --     ["<Tab>"] = cmp.mapping(function(fallback)
      --       if cmp.visible() then
      --         cmp.select_next_item()
      --       elseif luasnip.expandable() then
      --         luasnip.expand()
      --       elseif luasnip.expand_or_jumpable() then
      --         luasnip.expand_or_jump()
      --       elseif check_backspace() then
      --         fallback()
      --       else
      --         fallback()
      --       end
      --     end, {
      --       "i",
      --       "s",
      --     }),
      --     ["<S-Tab>"] = cmp.mapping(function(fallback)
      --       if cmp.visible() then
      --         cmp.select_prev_item()
      --       elseif luasnip.jumpable(-1) then
      --         luasnip.jump(-1)
      --       else
      --         fallback()
      --       end
      --     end, {
      --       "i",
      --       "s",
      --     }),
      --   }),
      -- })
    end,
  },
  -- Extras
  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },
  -- {
  --   "dmmulroy/tsc.nvim",
  --   event = "VeryLazy",
  -- },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        debug = false,
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        -- hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        -- code action title icon
        code_action_icon = " ",
        code_action_prompt = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,

        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          quit = "q",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },

        hover = {
          max_width = 0.5,
        },

        code_action_keys = { quit = "q", exec = "<CR>" },
        rename_action_keys = { quit = "<C-c>", exec = "<CR>" },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    event = { "BufReadPre", "BufNewFile" },
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   event = "LspAttach",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = function()
      require("symbols-outline").setup()
    end,
  },
  -- {
  --   "VidocqH/lsp-lens.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("lsp-lens").setup({
  --       sections = {
  --         definition = true,
  --         references = true,
  --         implements = true,
  --         git_authors = false,
  --       },
  --     })
  --   end,
  -- },
}
