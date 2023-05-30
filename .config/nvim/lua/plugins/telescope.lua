return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          })
        end,
        desc = "Find Files",
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("media_files")
      end,
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
