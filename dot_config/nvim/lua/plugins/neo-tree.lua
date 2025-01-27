local mini_icons = require("mini.icons")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.nvim", -- Mini.nvim for icons
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
      { "<leader>fb", "<cmd>Neotree toggle buffers<cr>", desc = "Toggle Buffers" },
      { "<leader>fg", "<cmd>Neotree toggle git_status<cr>", desc = "Toggle Git Files" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        sources = {
          "filesystem",
          "buffers",
          "git_status",
        },
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 38,
          side = "right",
          adaptive_size = false,
          preserve_window_proportions = true,
        },
        filesystem = {
          follow_current_file = { enabled = true },
          group_empty_dirs = true,
          use_libuv_file_watcher = true,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "name",
          indent_markers = {
            enable = false,
          },
          icons = {
            show = {
              file = true,
              folder = true,
              git = true,
            },
            glyphs = {
              default = mini_icons.file,
              folder = mini_icons.folder,
              folder_open = mini_icons.folder_open,
              folder_empty = mini_icons.folder_empty,
              git = mini_icons.git,
              git_added = mini_icons.git_added,
              git_modified = mini_icons.git_modified,
              git_renamed = mini_icons.git_renamed,
              git_deleted = mini_icons.git_deleted,
            },
          },
        },
        window = {
          position = "right",
          width = 38,
          mappings = {
            ["o"] = { "open", nowait = true },
            ["oc"] = "noop",
            ["od"] = "noop",
            ["og"] = "noop",
            ["om"] = "noop",
            ["on"] = "noop",
            ["os"] = "noop",
            ["ot"] = "noop",
            ["-"] = "open_split",
            ["|"] = "open_vsplit",
          },
        },
      })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
