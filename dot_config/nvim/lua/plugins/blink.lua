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
      optional = true,
      opts = {},
    },
    "archie-judd/blink-cmp-words",
  },
  opts = function()
    local providers = {}
    local default = { "lsp", "path", "snippets", "buffer" }

    -- Always included
    providers.thesaurus = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.thesaurus",
      opts = {
        score_offset = 0,
        pointer_symbols = { "!", "&", "^" },
      },
    }

    providers.dictionary = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.dictionary",
      opts = {
        dictionary_search_threshold = 3,
        score_offset = 0,
        pointer_symbols = { "!", "&", "^" },
      },
    }

    -- Optional providers (only add if available)
    if pcall(require, "lazydev.integrations.blink") then
      providers.lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      }
      table.insert(default, "lazydev")
    end

    if pcall(require, "vim_dadbod_completion.blink") then
      providers.dadbod = {
        name = "Dadbod",
        module = "vim_dadbod_completion.blink",
      }
      table.insert(default, "dadbod")
    end

    if pcall(require, "codecompanion.blink") then
      providers.codecompanion = {
        name = "CodeCompanion",
        module = "codecompanion.blink",
      }
      table.insert(default, "codecompanion")
    end

    if pcall(require, "blink-cmp-copilot") then
      providers.copilot = {
        name = "Copilot",
        module = "blink-cmp-copilot",
        score_offset = 50,
      }
      table.insert(default, "copilot")
    end

    -- Final sources table
    local sources = {
      compat = {},
      default = default,
      providers = providers,
      per_filetype = {
        text = { "dictionary" },
        markdown = { "thesaurus" },
        codecompanion = providers.codecompanion and { "codecompanion" } or nil,
        ["*"] = providers.copilot and { "copilot" } or nil,
      },
    }

    return {
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
        menu = {
          border = "rounded",
          winblend = 0,
          scrollbar = true,
          draw = {
            treesitter = { "lsp" },
          },
        },
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
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          winblend = 0,
          scrollbar = false,
        },
      },
      sources = sources,
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
          Copilot = "",
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",
          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",
          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",
          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",
          Keyword = "󰻾",
          Constant = "󰏿",
          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
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
    }
  end,
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

    opts.sources.compat = nil -- clean up
    require("blink.cmp").setup(opts)
  end,
}
