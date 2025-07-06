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
    "onsails/lspkind.nvim",
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

    providers.buffer = {
      min_keyword_length = 5,
      max_items = 5,
    }

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

    -- Final sources table
    local sources = {
      compat = {},
      default = default,
      providers = providers,
      per_filetype = {
        text = { "dictionary" },
        markdown = { "thesaurus" },
        codecompanion = providers.codecompanion and { "codecompanion" } or nil,
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
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          -- winblend = 0,
          scrollbar = true,
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,

          draw = {
            columns = {
              { "kind_icon", "label", gap = 1 },
              { "kind" },
            },
            components = {
              kind = {
                text = function(item)
                  return item.kind
                end,
                highlight = "CmpItemKind",
              },
              kind_icon = {
                text = function(item)
                  local kind = require("lspkind").symbol_map[item.kind] or ""
                  return kind .. " "
                end,
                highlight = "CmpItemKind",
              },
              label = {
                text = function(item)
                  return item.label
                end,
                highlight = "CmpItemAbbr",
              },
            },
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            -- winblend = 0,
            scrollbar = true,
          },
          treesitter_highlighting = true,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          -- winblend = 0,
          scrollbar = false,
        },
      },
      sources = sources,
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
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
