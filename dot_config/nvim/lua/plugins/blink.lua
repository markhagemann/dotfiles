---@diagnostic disable: missing-fields
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  opts_extend = {
    "sources.default",
    "sources.compat",
  },
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
    },
    "archie-judd/blink-cmp-words",
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      list = {
        selection = {
          preselect = false,
        },
      },
      -- menu = {
      --   border = "rounded",
      --   winblend = 0,
      --   scrollbar = true,
      --   draw = {
      --     -- columns = { { "kind_icon", "label", "label_description", gap = 1 } },
      --     components = {
      --       kind_icon = {
      --         ellipsis = false,
      --         text = function(ctx)
      --           local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
      --           return kind_icon
      --         end,
      --         -- Optionally, you may also use the highlights from mini.icons
      --         highlight = function(ctx)
      --           local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
      --           return hl
      --         end,
      --       },
      --     },
      --     treesitter = { "lsp" },
      --   },
      -- },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winblend = 0,
          scrollbar = true,
        },
        treesitter_highlighting = true,
      },
    },
    -- Experimental signature help support
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winblend = 0,
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
      },
    },
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { "lsp", "path", "lazydev", "snippets", "buffer" },
      -- default = { "lsp", "path", "snippets", "buffer", "dadbod" },
      providers = {
        -- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        thesaurus = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.thesaurus",
          -- All available options
          opts = {
            -- A score offset applied to returned items.
            -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
            score_offset = 0,

            -- Default pointers define the lexical relations listed under each definition,
            -- see Pointer Symbols below.
            -- Default is as below ("antonyms", "similar to" and "also see").
            pointer_symbols = { "!", "&", "^" },
          },
        },
        dictionary = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.dictionary",
          -- All available options
          opts = {
            -- The number of characters required to trigger completion.
            -- Set this higher if completion is slow, 3 is default.
            dictionary_search_threshold = 3,

            -- See above
            score_offset = 0,

            -- See above
            pointer_symbols = { "!", "&", "^" },
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
      -- Setup completion by filetype
      per_filetype = {
        text = { "dictionary" },
        markdown = { "thesaurus" },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      -- kind_icons = {},
    },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- Unset custom prop to pass blink.cmp validation
    opts.sources.compat = nil

    require("blink.cmp").setup(opts)
  end,
}
