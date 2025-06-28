return {
  "yetone/avante.nvim",
  enabled = vim.env.ENABLE_AI_PLUGINS == "true",
  -- enabled = false,
  build = "make BUILD_FROM_SOURCE=true RUSTONIG_SYSTEM_LIBONIG=1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "ibhagwan/fzf-lua",
    "folke/snacks.nvim",
    "echasnovski/mini.icons",
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
          use_absolute_path = true,
        },
      },
    },
  },
  cmd = { "AvanteToggle" },
  keys = {
    { "<leader>at", "<Cmd>AvanteToggle<CR>", desc = "avante: toggle" },
    { "<leader>aC", "<Cmd>AvanteClear<CR>", desc = "avante: clear" },
  },
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "openrouter",
    providers = {
      openrouter = {
        __inherited_from = "openai",
        api_key_name = "AVANTE_API_KEY",
        disable_tools = true,
        endpoint = "https://openrouter.ai/api/v1",
        -- model = "meta-llama/llama-4-maverick",
        model = "mistralai/mistral-nemo",
        extra_request_body = {
          max_tokens = 4096,
        },
      },
    },
  },
}
