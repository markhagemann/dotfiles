local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   event = "LspAttach",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {}, -- your configuration
  -- },
  { "js-everts/cmp-tailwind-colors" },
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
  -- Core Completion Plugin
  {
    "hrsh7th/nvim-cmp",
    commit = "b356f2c",
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
      "f3fora/cmp-spell",
    },
    config = function(_, opts)
      -- See `:help cmp`
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local sorting = defaults.sorting
      local types = require("cmp.types")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      luasnip.config.setup({})

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline({
          ["<c-space>"] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<c-space>"] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      -- Function to sort LSP snippets, so that they appear at the end of LSP suggestions
      local function deprioritize_snippet(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return true
        end
      end

      -- Insert `deprioritize_snippet` first in the `comparators` table, so that it has priority
      -- over the other default comparators
      table.insert(sorting.comparators, 1, deprioritize_snippet)

      local symbol_map = {
        Boolean = "󰨙  ",
        Codeium = "󰘦  ",
        Control = "  ",
        Text = "  ",
        Method = "  ",
        Function = "  ",
        Constructor = "  ",
        Field = "  ",
        Variable = "  ",
        Class = "  ",
        Interface = "  ",
        Module = "  ",
        Property = "  ",
        Unit = "  ",
        Value = "  ",
        Enum = "  ",
        Keyword = "  ",
        Snippet = "  ",
        Color = "  ",
        File = "  ",
        Reference = "  ",
        Folder = "  ",
        EnumMember = "  ",
        Constant = "  ",
        Struct = "  ",
        Event = "  ",
        Operator = "  ",
        TypeParameter = "  ",
        Array = "  ",
        Collapsed = "  ",
        Copilot = "  ",
        Key = " ",
        Namespace = "󰦮 ",
        Null = "  ",
        Number = "󰎠  ",
        Object = "  ",
        Package = "  ",
        String = "  ",
        TabNine = "󰏚  ",
      }

      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

      cmp.setup({
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = sorting,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- similar to VSCode completion order
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            item = require("nvim-highlight-colors").format(entry, item)
            -- the item.abbr returns the user's virtual object eg. the square when it's Color entry
            if item.abbr == "" then
              -- I have kind_icons table looks like kind_icons = { Text = "Tt (this is icon)", ...more icons }
              item.kind = string.format("%s", symbol_map[item.menu])
            else
              item.kind = item.abbr
            end
            item.abbr = item.word
            item.kind_hl_group = item.abbr_hl_group or nil
            item.abbr_hl_group = nil
            return item
          end,
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
          ["<C-s>"] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto }),
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
          { name = "nvim_lsp", max_item_count = 30 },
          { name = "nvim_lsp_signature_help", max_item_count = 30 },
          { name = "nvim_lua", max_item_count = 30 },
          { name = "buffer", max_item_count = 30 },
          { name = "path", max_item_count = 30 },
          {
            name = "html-css",
            option = {
              enable_on = {
                "html.handlebars",
                "html",
                "jsx",
                "tsx",
                "vue",
              }, -- set the file types you want the plugin to work on
              file_extensions = { "css", "sass", "scss" }, -- set the local filetypes from which you want to derive classes
              style_sheets = {
                -- example of remote styles, only css no js for now
                -- "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
                -- "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
              }, -- your configuration here
            },
          },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
              preselect_correct_word = true,
            },
          },
          { name = "luasnip" },
        },
      })
    end,
  },
}
