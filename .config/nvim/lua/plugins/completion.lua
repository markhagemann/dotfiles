local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {}, -- your configuration
  -- },
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
    event = "InsertEnter",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      -- Snippet Engine & its associated nvim-cmp source
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
    config = function(_, opts)
      -- See `:help cmp`
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local sorting = defaults.sorting
      local types = require("cmp.types")
      local lspkind = require("lspkind")

      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

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
          expand = function(arg)
            vim.snippet.expand(arg.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = {
          -- before = require("tailwind-tools.cmp").lspkind_format,
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            if entry.source.name == "html-css" then
              vim_item.menu = entry.completion_item.menu
            else
              vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
              })[entry.source.name]
            end

            -- Kind icons
            vim_item.kind = string.format("%s %s", symbol_map[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            -- -- Source
            return vim_item
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
          ["<C-l>"] = cmp.mapping(function() end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function() end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
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
          { name = "snippets" },
        },
      })
    end,
  },
}
