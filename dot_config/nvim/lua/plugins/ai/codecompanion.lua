-- local current_model = vim.env.DEFAULT_MODEL
-- local available_models = vim.env.AVAILABLE_MODELS
--
-- local function select_model()
--   vim.ui.select(available_models, {
--     prompt = "Select Model:",
--   }, function(choice)
--     if choice then
--       current_model = choice
--       vim.notify("Selected model: " .. current_model)
--     end
--   end)
-- end

local default_picker_opts = {
  opts = {
    provider = "snacks",
  },
}

return {
  -- AI coding assistant with chat and inline editing capabilities via OpenRouter
  "olimorris/codecompanion.nvim",
  version = "^18",
  enabled = vim.env.ENABLE_CODECOMPANION == "true",
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openrouter",
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
          adapter = "copilot",
        },
      },
      adapters = {

        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },

          copilot = "copilot",

          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "mistralai/devstral-2512:free",
                },
              },
            })
          end,
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
      },
      interactions = {
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
