return {
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        close = "<esc>",
        go_in_entry = "o",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
        reset = "<BS>",
        reveal_cwd = ".",
        show_help = "g?",
        synchronize = "s",
        trim_left = "<",
        trim_right = ">",
      },

      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      },

      options = {
        use_as_default_explorer = true,
        permanent_delete = false,
      },
    },

    keys = {
      {
        -- Open the directory of the file currently being edited
        -- If the file doesn't exist because you maybe switched to a new git branch
        -- open the current working directory
        "<leader>e",
        function()
          local buf_name = vim.api.nvim_buf_get_name(0)
          local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
          if vim.fn.filereadable(buf_name) == 1 then
            -- Pass the full file path to highlight the file
            require("mini.files").open(buf_name, true)
          elseif vim.fn.isdirectory(dir_name) == 1 then
            -- If the directory exists but the file doesn't, open the directory
            require("mini.files").open(dir_name, true)
          else
            -- If neither exists, fallback to the current working directory
            require("mini.files").open(vim.uv.cwd(), true)
          end
        end,
        desc = "Open mini.files (Directory of Current File or CWD if not exists)",
      },
      -- Open the current working directory
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },

    config = function(_, opts)
      -- Set up mini.files
      require("mini.files").setup(opts)
      -- Load custom keymaps
      mini_files_km.setup(opts)

      -- Load Git integration
      -- git config is slowing mini.files too much, so disabling it
      mini_files_git.setup()
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "BufEnter",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "echasnovski/mini.files",
    event = "BufEnter",
    version = "*",
    config = function()
      require("mini.files").setup()
    end,
  },
  {
    "echasnovski/mini.hipatterns",
    event = "VimEnter",
    version = "*",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME:', 'HACK:', 'TODO:', 'NOTE:'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function()
      require("mini.icons").setup({
        filetype = {
          json = { glyph = "" },
          jsonc = { glyph = "" },

          sh = { glyph = "󰐣", hl = "MiniIconsBlue" },
          zsh = { glyph = "󰐣" },
          bash = { glyph = "󰐣" },
        },
        extension = {
          conf = { glyph = "󰛸", hl = "MiniIconsBlue" },
        },
      })
    end,
  },
  -- { "echasnovski/mini.indentscope", version = "*", event = "BufEnter" },
  {
    "echasnovski/mini.surround",
    event = "BufEnter",
    version = "*",
    opts = {},
  },
}
