local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  {
    "Jezda1337/nvim-html-css",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("html-css"):setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim", -- Completion menu icons

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-buffer", -- Buffer completion
      "hrsh7th/cmp-path", -- Path completion
      "hrsh7th/cmp-cmdline", -- Command-line completion
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-nvim-lua", -- Nvim builtins completion
      "hrsh7th/cmp-nvim-lsp-signature-help", -- Signature
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      luasnip.config.setup({})

      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      cmp.setup({
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            },
            symbol_map = {
              Array = " ",
              Boolean = "󰨙 ",
              Class = " ",
              Codeium = "󰘦 ",
              Color = " ",
              Control = " ",
              Collapsed = " ",
              Constant = "󰏿 ",
              Constructor = " ",
              Copilot = " ",
              Enum = " ",
              EnumMember = " ",
              Event = " ",
              Field = " ",
              File = " ",
              Folder = " ",
              Function = "󰊕 ",
              Interface = " ",
              Key = " ",
              Keyword = " ",
              Method = "󰊕 ",
              Module = " ",
              Namespace = "󰦮 ",
              Null = " ",
              Number = "󰎠 ",
              Object = " ",
              Operator = " ",
              Package = " ",
              Property = " ",
              Reference = " ",
              Snippet = " ",
              String = " ",
              Struct = "󰆼 ",
              TabNine = "󰏚 ",
              Text = " ",
              TypeParameter = " ",
              Unit = " ",
              Value = " ",
              Variable = "󰀫 ",
            },
          }),
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(cmp_select), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          {
            name = "html-css",
            option = {
              enable_on = {
                "html",
                "jsx",
                "tsx",
                "vue",
              }, -- set the file types you want the plugin to work on
              file_extensions = { "css", "sass", "scss" }, -- set the local filetypes from which you want to derive classes
              style_sheets = {
                -- example of remote styles, only css no js for now
                "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
                "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
              }, -- your configuration here
            },
          },
        },
      })
    end,
  },
}
