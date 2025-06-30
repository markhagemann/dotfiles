local current_model = vim.env.DEFAULT_MODEL
local available_models = vim.env.AVAILABLE_MODELS
local function select_model()
  vim.ui.select(available_models, {
    prompt = "Select  Model:",
  }, function(choice)
    if choice then
      current_model = choice
      vim.notify("Selected model: " .. current_model)
    end
  end)
end

return {
  "olimorris/codecompanion.nvim",
  enabled = vim.env.ENABLE_AI_PLUGINS == "true",
  -- enabled = false,
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openrouter",
        },
        inline = {
          adapter = "openrouter",
        },
      },
      adapters = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = current_model,
              },
            },
          })
        end,
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 14,
            -- Picker interface (auto resolved to a valid picker)
            picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = true,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "ai: actions" },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "ai: chat" },
    { "<leader>a+", "<cmd>CodeCompanionChat Add<cr>", desc = "ai: add file to chat", mode = { "v" } },
    { "<leader>as", select_model, desc = "ai: select model" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
    {
      -- support for image pasting
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
