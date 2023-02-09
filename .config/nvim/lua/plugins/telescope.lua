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
}
