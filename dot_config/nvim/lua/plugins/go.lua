return {
  {
    "devkvlt/go-tags.nvim",
    ft = "go",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      commands = {
        ["GoTagsAddJSON"] = { "-add-tags", "json" },
        ["GoTagsRemoveJSON"] = { "-remove-tags", "json" },
      },
    },
    keys = {
      {
        "<leader>gaj",
        "<ESC><CMD>GoTagsAddJSON<CR>",
        mode = { "n" },
        desc = "go tags add json",
      },
      {
        "<leader>grj",
        "<ESC><CMD>GoTagsRemoveJSON<CR>",
        mode = { "n" },
        desc = "go tags remove json",
      },
    },
  },
  {
    "fang2hou/go-impl.nvim",
    ft = "go",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",

      -- Choose one of the following fuzzy finder
      "folke/snacks.nvim",
      "ibhagwan/fzf-lua",
    },
    opts = {},
    keys = {
      {
        "<leader>gi",
        function()
          require("go-impl").open()
        end,
        mode = { "n" },
        desc = "find go implementations",
      },
    },
  },
  {
    "yanskun/gotests.nvim",
    ft = "go",
    opts = {},
    -- config = function()
    --   require("gotests").setup()
    -- end,
    keys = {

      {
        "<leader>gtc",
        "<ESC><CMD>GoTests<CR>",
        mode = { "n", "v" },
        desc = "generate tests at current line or visual mode",
      },
      {
        "<leader>gta",
        "<ESC><CMD>GoTestsAll<CR>",
        mode = { "n" },
        desc = "generate tests for all functions and methods",
      },
    },
  },
}
