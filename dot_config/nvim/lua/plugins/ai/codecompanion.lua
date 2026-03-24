local default_picker_opts = {
  opts = {
    provider = "snacks",
  },
}

local default_adapter = (vim.env.ENABLE_COPILOT == "true" and "copilot")
  or (vim.env.OPENROUTER_API_KEY and "openrouter")
  or nil

return {
  -- AI coding assistant with chat and inline editing capabilities via OpenRouter
  "olimorris/codecompanion.nvim",
  version = "^19",
  enabled = vim.env.ENABLE_CODECOMPANION == "true",
  config = function()
    require("codecompanion").setup({
      adapters = {
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
        cli = vim.env.CODECOMPANION_AGENT and {
          window = {
            layout = "vertical",
            width = 0.4,
          },
        } or nil,
      },
      interactions = {
        chat = {
          adapter = default_adapter,
          icons = {
            chat_context = "📎️",
          },
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
        inline = {
          adapter = default_adapter,
        },
        cli = vim.env.CODECOMPANION_AGENT and {
          agent = vim.env.CODECOMPANION_AGENT,
          agents = {
            [vim.env.CODECOMPANION_AGENT] = {
              cmd = vim.env.CODECOMPANION_AGENT == "claude_code" and "claude" or vim.env.CODECOMPANION_AGENT,
              args = {},
            },
          },
        } or nil,
        background = {
          adapter = default_adapter,
          chat = {
            opts = {
              enabled = default_adapter ~= nil,
            },
          },
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            auto_generate_title = false,
          },
        },
      },
    })
  end,
  keys = vim.env.CODECOMPANION_AGENT and {
    { "<leader>at", "<cmd>CodeCompanionCLI<cr>", desc = "AI: chat (CLI)" },
    { "<leader>ap", "<cmd>CodeCompanionCLI Ask<cr>", desc = "AI: prompt (CLI)" },
  } or {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI: actions" },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: chat" },
    { "<leader>ah", "<cmd>CodeCompanionHistory<cr>", desc = "AI: history" },
    { "<leader>a+", "<cmd>CodeCompanionChat Add<cr>", desc = "AI: add file to chat", mode = { "v" } },
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
