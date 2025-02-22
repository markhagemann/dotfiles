return {
  {
    "echasnovski/mini.files",
    opts = function(_, opts)
      -- I didn't like the default mappings, so I modified them
      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        close = "<esc>",
        -- Use this if you want to open several files
        go_in = "l",
        -- This opens the file, but quits out of mini.files (default L)
        go_in_plus = "<CR>",
        -- I swapped the following 2 (default go_out: h)
        -- go_out_plus: when you go out, it shows you only 1 item to the right
        -- go_out: shows you all the items to the right
        go_out = "H",
        go_out_plus = "h",
        -- Default <BS>
        reset = "<BS>",
        -- Default @
        reveal_cwd = ".",
        show_help = "g?",
        -- Default =
        synchronize = "s",
        trim_left = "<",
        trim_right = ">",

        -- Below I created an autocmd with the "," keymap to open the highlighted
        -- directory in a tmux pane on the right
      })

      opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      })

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = true,
        -- If set to false, files are moved to the trash directory
        -- To get this dir run :echo stdpath('data')
        -- ~/.local/share/neobean/mini.files/trash
        permanent_delete = false,
      })
      return opts
    end,

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
