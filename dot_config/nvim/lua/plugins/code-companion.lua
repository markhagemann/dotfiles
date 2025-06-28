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
  },
}
