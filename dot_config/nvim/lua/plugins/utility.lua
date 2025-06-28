return {
  {
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        enable = false,
      },
      navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = true,
      },
    },
    keys = {
      {
        "<C-h>",
        function()
          require("tmux").move_left()
        end,
        desc = "navigate left",
      },
      {
        "<C-j>",
        function()
          require("tmux").move_top()
        end,
        desc = "navigate top",
      },
      {
        "<C-k>",
        function()
          require("tmux").move_top()
        end,
        desc = "navigate top",
      },
      {
        "<C-l>",
        function()
          require("tmux").move_right()
        end,
        desc = "navigate right",
      },
    },
  },
  { "arthurxavierx/vim-caser", event = "BufEnter" },
  {
    "barrett-ruth/import-cost.nvim",
    event = "BufEnter",
    build = "sh install.sh yarn",
    -- if on windows
    -- build = 'pwsh install.ps1 yarn',
    config = function()
      require("import-cost").setup({})
    end,
  },
  {
    "bloznelis/before.nvim",
    event = "BufEnter",
    config = function()
      local before = require("before")
      before.setup()

      -- Jump to previous entry in the edit history
      vim.keymap.set("n", "<leader>jl", before.jump_to_last_edit, { desc = "jump to last edit" })

      -- Jump to next entry in the edit history
      vim.keymap.set("n", "<leader>jn", before.jump_to_next_edit, { desc = "jump to next edit" })

      -- Look for previous edits in quickfix list
      vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, { desc = "open edits in quickfix" })

      -- Look for previous edits in telescope (needs telescope, obviously)
      vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, { desc = "open edits in telescope" })
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guifg = "#bb9af7", guibg = "#2d2a45" },
            InclineNormalNC = { guifg = "#414868", guibg = "none" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
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
    "brenoprata10/nvim-highlight-colors",
    lazy = false,
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end,
    keys = {
      {
        "<leader>gb",
        "<CMD>BlameToggle<CR>",
        desc = "git blame",
        noremap = true,
        silent = true,
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TodoTrouble", "TroubleToggle" },
    event = "VimEnter",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "diagnostics (trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "buffer diagnostics (trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "symbols (trouble)" },
    },
    opts = {},
  },
  -- {
  --   "folke/twilight.nvim",
  --   opts = {},
  --   event = "VeryLazy",
  --   keys = {
  --     { "<leader>tw", "<cmd>Twilight<cr>", desc = "toggle twilight" },
  --   },
  -- },
  -- {
  --   "HakonHarnes/img-clip.nvim",
  --   event = "BufEnter",
  --   keys = {
  --     -- suggested keymap
  --     { "<leader>pi", "<cmd>PasteImage<cr>", desc = "paste clipboard image" },
  --   },
  -- },
  {
    "jake-stewart/auto-cmdheight.nvim",
    event = "VeryLazy",
    opts = {
      -- max cmdheight before displaying hit enter prompt.
      max_lines = 5,

      -- number of seconds until the cmdheight can restore.
      duration = 2,

      -- whether key press is required to restore cmdheight.
      remove_on_key = true,
    },
  },
  {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#569CD6", bold = true, underline = true })
      vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#C586C0", underline = true })

      require("eyeliner").setup({
        -- show highlights only after keypress
        highlight_on_key = true,

        -- dim all other characters if set to true (recommended!)
        dim = false,

        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,

        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},

        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},

        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      })
    end,
  },
  {
    "kburdett/vim-nuuid",
    keys = {
      { "<leader>uu", "<Plug>Nuuid", desc = "generate uuid" },
    },
  },
  {
    "lewis6991/spaceless.nvim",
    event = { "BufLeave", "InsertEnter" },
    opts = {},
  },
  {
    "m4xshen/hardtime.nvim",
    event = "BufEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "aerial",
        "alpha",
        "checkhealth",
        "codecompanion",
        "dapui*",
        "dbui",
        "Diffview*",
        "Dressing*",
        "grug-far",
        "help",
        "httpResult",
        "lazy",
        "mason",
        "minifiles",
        "Neogit*",
        "neo-tree",
        "neo-tree*",
        "neotest-summary",
        "netrw",
        "noice",
        "notify",
        "NvimTree",
        "oil",
        "prompt",
        "qf",
        "TelescopePrompt",
        "Trouble",
        "undotree",
      },
      max_count = 6,
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
    end,
    keys = {
      {
        "<leader>sr",
        ":GrugFar<cr>",
        desc = "search/replace across all files (grug)",
      },
      {
        "<leader>sc",
        "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand(' % ') } })<cr>",
        desc = "search/replace across current file (grug)",
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mappings = {
          t = { j = { false } }, --lazygit navigation fix
          v = { j = { k = false } }, -- visual select fix
        },
      })
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", ":UndotreeToggle<cr>", desc = "toggle undo tree" },
    },
  },
  {
    "nmac427/guess-indent.nvim",
    event = "BufEnter",
    config = function()
      require("guess-indent").setup({
        auto_cmd = false, -- Set to false to disable automatic execution
      })
      vim.cmd([[ autocmd BufReadPost * :silent GuessIndent ]])
      vim.keymap.set("n", "<Tab>g", vim.cmd.GuessIndent, { desc = "GuessIndent (manual)" })
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
    },
  },
  -- { "preservim/vim-pencil", event = "VeryLazy" },
  -- {
  --   "rachartier/tiny-glimmer.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     transparency_color = "#000000",
  --   },
  -- },
  {
    "propet/toggle-fullscreen.nvim",
    keys = {
      {
        "<leader>tf",
        function()
          require("toggle-fullscreen"):toggle_fullscreen()
        end,
        desc = "toggle fullscreen",
      },
    },
  },
  {
    "rmagatti/auto-session", -- auto save session
    event = "VeryLazy",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = {
          "~/",
          "~/Downloads",
          "~/Documents",
        },
        auto_session_use_git_branch = true,
        auto_save_enabled = true,
      })
    end,
  },
  {
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
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
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
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   tag = "v0.4.1",
  --   event = "BufEnter",
  --   opts = {
  --     cursor_color = "#5f87cd",
  --     stiffness = 0.9,
  --     trailing_stiffness = 0.6,
  --     gamma = 0.25,
  --   },
  -- },
  { "sitiom/nvim-numbertoggle", event = "BufEnter" },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  "SyedAsimShah1/quick-todo.nvim",
  keys = {
    {
      "<leader>tt",
      "<cmd>lua require('quick-todo').open_todo()<CR>",
      mode = { "n" },
      silent = true,
      desc = "toggle todo",
    },
  },
  config = function()
    require("quick-todo").setup({
      window = {
        height = 0.5,
        width = 0.5,
        winblend = 0,
        border = "rounded",
      },
    })
  end,
  -- Sets yaml indentation wrong - guess indent fixes
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- {
  --   "volskaya/windovigation.nvim",
  --   lazy = false,
  --   opts = {},
  -- },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "ziontee113/color-picker.nvim",
    event = "BufEnter",
    config = function()
      local opts = { noremap = true, silent = true, desc = "pick colour" }
      vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<cr>", opts)
      require("color-picker").setup({
        ["icons"] = { "-", "" },
      })
    end,
  },
}
