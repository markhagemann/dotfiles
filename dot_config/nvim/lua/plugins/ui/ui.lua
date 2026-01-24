return {
  {
    -- Minimal buffer line showing filename in floating window
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local colors = require("utils.colors").theme
      require("incline").setup({
        highlight = {
          groups = {
            -- InclineNormal = { guifg = "#bb9af7", guibg = "#2d2a45" },
            InclineNormal = { guifg = colors.magenta, guibg = "none" },
            InclineNormalNC = { guifg = colors.bred, guibg = "none" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = "smart",
        },
        render = function(props)
          local mini_icons = require("mini.icons")
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = mini_icons.get("file", filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    -- Highlight color codes (#rrggbb, rgb(), etc.) with their actual colors
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  {
    -- Subtle cursor line highlighting effect
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    -- opts = {
    --   transparency_color = "#000000",
    -- },
  },
  {
    -- Highlight all occurrences of word under cursor using LSP
    "RRethy/vim-illuminate",
    event = "BufEnter",
    opts = {
      delay = 200,
      filetypes_denylist = {
        "NvimTree",
      },
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      vim.cmd("hi IlluminatedWordText guibg=none gui=underline")
      vim.cmd("hi IlluminatedWordRead guibg=none gui=underline")
      vim.cmd("hi IlluminatedWordWrite guibg=none gui=underline")

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next reference" },
      { "[[", desc = "Prev reference" },
    },
  },
  {
    -- Highlight code blocks and chunks using tree-sitter
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          priority = 15,
          style = {
            { fg = "#b46eff" },
            { fg = "#c21f30" },
          },
          use_treesitter = true,
          chars = {
            left_arrow = "─",
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = "─",
            -- right_arrow = ">",
          },
          textobject = "",
          max_file_size = 1024 * 1024,
          error_sign = true,
          duration = 200,
          delay = 300,
        },
        indent = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          enable = false,
        },
      })
    end,
  },
}
