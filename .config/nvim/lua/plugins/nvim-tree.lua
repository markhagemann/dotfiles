local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "l", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "|", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "-", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "<F5>", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "n", api.fs.create, opts("Create"))
  vim.keymap.set("n", "N", api.fs.create, opts("Create"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set("n", "}c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
      { "<leader>f-", "<cmd>NvimTreeFindFileToggle<cr>", desc = "File Explorer" },
    },

    config = function()
      require("nvim-tree").setup({
        on_attach = on_attach,
        filters = {
          dotfiles = false,
          custom = { "^.git$", "^.DS_store$" },
        },
        live_filter = {
          always_show_folders = false,
        },
        disable_netrw = true,
        hijack_netrw = true,
        -- INFO: deprecated
        -- open_on_setup = false,
        -- ignore_ft_on_setup = {"alpha"},
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        view = {
          adaptive_size = false,
          centralize_selection = false,
          preserve_window_proportions = true,
          side = "left",
          width = 38,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          timeout = 400,
        },
        filesystem_watchers = {
          enable = true,
          ignore_dirs = {
            "node_modules",
            ".git",
          },
        },
        renderer = {
          highlight_git = true,
          root_folder_label = false,
          highlight_opened_files = "name",
          indent_markers = {
            enable = false,
          },
          special_files = { "package.json", "README.md", "readme.md" },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
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
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
