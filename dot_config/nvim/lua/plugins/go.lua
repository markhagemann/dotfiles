return {
  {
    -- Go struct tag management (add/remove JSON tags)
    "romus204/go-tagger.nvim",
    ft = "go",
    keys = {
      {
        "<leader>gta",
        "<ESC><CMD>AddGoTags<CR>",
        mode = { "n" },
        desc = "Go tags add json",
      },
      {
        "<leader>gtr",
        "<ESC><CMD>RemoveGoTags<CR>",
        mode = { "n" },
        desc = "Go tags remove json",
      },
    },
  },
  {
    -- Find and navigate Go interface implementations
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
        desc = "Find go implementations",
      },
    },
  },
  {
    -- Generate Go test files and test functions
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
        desc = "Generate tests at current line or visual mode",
      },
      {
        "<leader>gtf",
        "<ESC><CMD>GoTestsAll<CR>",
        mode = { "n" },
        desc = "Generate tests for all functions and methods",
      },
    },
  },
}
