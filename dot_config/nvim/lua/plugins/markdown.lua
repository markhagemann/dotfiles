return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    event = "VeryLazy",
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    keys = {
      {
        "<leader>tc",
        function()
          require("obsidian").util.toggle_checkbox()
        end,
        desc = "toggle checkbox",
      },
      { "<leader>obt", ":ObsidianToday<CR>", desc = "Obsidian: View Today's Notes" },
    },
    opts = {
      mappings = {
        -- Toggle check-boxes.
        ["<leader>tc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          desc = "Toggle checkbox",
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      daily_notes = {
        folder = "Notes/Daily",
      },
      workspaces = {
        {
          name = "Notes",
          path = "~/Obsidian/Notes",
        },
      },
      ui = { enable = false },
    },
  },
}
