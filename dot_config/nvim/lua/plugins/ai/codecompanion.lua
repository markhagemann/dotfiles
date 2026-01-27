local default_picker_opts = {
  opts = {
    provider = "snacks",
  },
}

-- Get the mise global node bin path dynamically
local function get_mise_global_node_bin()
  local version = vim.fn.system("mise global node 2>/dev/null"):gsub("%s+", "")
  if version and version ~= "" then
    return vim.fn.expand("~/.local/share/mise/installs/node/" .. version .. "/bin")
  end
  return nil
end

return {
  -- AI coding assistant with chat and inline editing capabilities via OpenRouter
  "olimorris/codecompanion.nvim",
  version = "^18",
  enabled = vim.env.ENABLE_CODECOMPANION == "true",
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = vim.env.ENABLE_CURSOR == "true" and "cursor" or "copilot",
          slash_commands = {
            -- Files / buffers
            file = default_picker_opts,
            buffer = default_picker_opts,
            buffers = default_picker_opts,

            -- Project / filesystem
            files = default_picker_opts,
            cwd = default_picker_opts,

            -- Git
            git_file = default_picker_opts,
            git_files = default_picker_opts,
            git_diff = default_picker_opts,
            git_commit = default_picker_opts,

            -- Diagnostics / symbols
            diagnostic = default_picker_opts,
            symbols = default_picker_opts,

            -- Misc
            help = default_picker_opts,
            recent = default_picker_opts,
            time = default_picker_opts,
            date = default_picker_opts,
          },
        },
        inline = {
          adapter = vim.env.ENABLE_COPILOT and "copilot",
        },
      },
      adapters = {
        acp = {
          opts = {
            show_presets = false,
          },
          -- cursor-acp adapter (only available if ENABLE_CURSOR=true)
          -- Uses @blowmage/cursor-agent-acp for better security controls
          -- Absolute path to avoid mise Node version switching issues
          cursor = vim.env.ENABLE_CURSOR == "true" and function()
            local mise_bin = get_mise_global_node_bin()
            local cmd = mise_bin and (mise_bin .. "/cursor-agent-acp") or "cursor-agent-acp"
            return require("codecompanion.adapters.acp").extend("claude_code", {
              name = "cursor",
              formatted_name = "Cursor",
              commands = {
                default = { cmd },
              },
            })
          end or nil,
        },
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },
          copilot = vim.env.ENABLE_COPILOT == "true" and "copilot" or nil,
          openrouter = vim.env.OPENROUTER_API_KEY and function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
                models_endpoint = "/models",
              },
              schema = {
                model = {
                  default = "mistralai/devstral-2512:free",
                },
              },
            })
          end or nil,
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
      },
      interactions = {
        -- Background interactions (title generation, etc.) require HTTP adapter
        background = {
          adapter = vim.env.ENABLE_COPILOT == "true" and "copilot"
            or (vim.env.OPENROUTER_API_KEY and "openrouter" or nil),
          chat = {
            opts = {
              -- Only enable background interactions if an HTTP adapter is available
              enabled = (vim.env.ENABLE_COPILOT == "true" or vim.env.OPENROUTER_API_KEY) and true or false,
            },
          },
        },
        chat = {
          icons = {
            chat_context = "📎️", -- You can also apply an icon to the fold
          },
          fold_context = true,
          fold_reasoning = true,
          show_reasoning = true,
          tools = {
            ["cmd_runner"] = {
              opts = {
                require_approval_before = true,
              },
            },
          },
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Disable auto title generation when using ACP adapters (cursor)
            -- Title generation requires an HTTP adapter (copilot/openrouter)
            auto_generate_title = false,
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI: actions" },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: chat" },
    { "<leader>ah", "<cmd>CodeCompanionHistory<cr>", desc = "AI: history" },
    { "<leader>a+", "<cmd>CodeCompanionChat Add<cr>", desc = "AI: add file to chat", mode = { "v" } },
    -- { "<leader>as", select_model, desc = "AI: select model" },
  },
  dependencies = {
    -- Utility library for Neovim plugins (async, file operations, etc.)
    "nvim-lua/plenary.nvim",
    -- Tree-sitter integration for code parsing
    "nvim-treesitter/nvim-treesitter",
    -- Chat history management for CodeCompanion
    "ravitemer/codecompanion-history.nvim",
    {
      -- Support for image pasting in markdown and chat buffers
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
