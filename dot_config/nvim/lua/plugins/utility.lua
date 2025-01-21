return {
  {
    "0x00-ketsu/autosave.nvim",
    config = function()
      require("autosave").setup({
        events = { "BufLeave" },
        prompt_message = function()
          return "Autosave: saved at " .. vim.fn.strftime("%H:%M:%S")
        end,
        debounce_delay = 5000,
      })
    end,
  },
  {
    "adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup()
    end,
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
      vim.keymap.set("n", "<leader>jl", before.jump_to_last_edit, { desc = "Jump to Last Edit" })

      -- Jump to next entry in the edit history
      vim.keymap.set("n", "<leader>jn", before.jump_to_next_edit, { desc = "Jump to Next Edit" })

      -- Look for previous edits in quickfix list
      vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, { desc = "Open Edits in Quickfix" })

      -- Look for previous edits in telescope (needs telescope, obviously)
      vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, { desc = "Open Edits in Telescope" })
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
    "christoomey/vim-tmux-navigator",
    event = "BufEnter",
    keys = {
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Go to the previous pane" },
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to the left pane" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to the down pane" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to the up pane" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to the right pane" },
    },
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
  -- {
  --   "danilamihailov/beacon.nvim",
  --   event = "BufEnter",
  --   opts = {
  --     fps = 60, --- integer how smooth the animation going to be
  --     speed = 1, --- integer speed at which animation goes
  --     width = 5, --- integer width of the beacon window
  --     window_events = { "WinEnter", "FocusGained" }, -- table<string> what events trigger cursor highlight
  --     winblend = 0, --- integer starting transparency of beacon window :h winblend
  --     highlight = { bg = "#5f87cd", ctermbg = 21 }, -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
  --   },
  -- },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "FabijanZulj/blame.nvim",
    opts = {},
    keys = {
      {
        "<leader>tb",
        "<CMD>BlameToggle<CR>",
        desc = "Open git blame list",
        noremap = true,
        silent = true,
      },
    },
    config = function(_, opts)
      require("blame").setup(opts)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TodoTrouble", "TroubleToggle" },
    event = "VimEnter",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    opts = {},
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "folke/twilight.nvim",
    opts = {},
    event = "VeryLazy",
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "toggle twilight" },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
  {
    "harrisoncramer/gitlab.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim",
      "echasnovski/mini.icons",
    },
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
  {
    "kburdett/vim-nuuid",
    keys = {
      { "<leader>u", "<Plug>Nuuid", desc = "Create New UUID" },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    keys = {
      { "<leader>qn", ":cnext<cr>", desc = "quickfix next" },
      { "<leader>qp", ":cprevious<cr>", desc = "quickfix previous" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "lewis6991/spaceless.nvim",
    event = { "BufLeave", "InsertEnter" },
    opts = {},
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   opts = {
  --     indent = {
  --       char = "│",
  --       tab_char = "│",
  --     },
  --     scope = { enabled = false, show_start = false, show_end = false },
  --   },
  --   event = "BufEnter",
  -- },
  {
    "m4xshen/hardtime.nvim",
    event = "BufEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "NvimTree",
        "TelescopePrompt",
        "aerial",
        "alpha",
        "checkhealth",
        "dapui*",
        "dbui",
        "Diffview*",
        "Dressing*",
        "grug-far",
        "help",
        "httpResult",
        "lazy",
        "Neogit*",
        "mason",
        "neotest-summary",
        "minifiles",
        "neo-tree*",
        "netrw",
        "noice",
        "notify",
        "prompt",
        "qf",
        "oil",
        "undotree",
        "Trouble",
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
        desc = "search & replace across all files (Grug)",
      },
      {
        "<leader>sc",
        "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand(' % ') } })<cr>",
        desc = "search & replace across current file (Grug)",
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", ":UndotreeToggle<cr>", desc = "undo tree" },
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
  { "preservim/vim-pencil", event = "VeryLazy" },
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
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          style = "#b46eff",
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
  {
    "sphamba/smear-cursor.nvim",
    event = "BufEnter",
    opts = {
      -- stiffness = 0.6,
      -- trailing_stiffness = 0.3,
      -- trailing_exponent = 0.1,
      -- distance_stop_animating = 0.1,
      -- hide_target_hack = false,
      -- Cursor color. Defaults to Cursor gui color
      cursor_color = "#5f87cd",

      -- Background color. Defaults to Normal gui background color
      -- normal_bg = "#282828",

      -- Smear cursor when switching buffers
      -- smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines
      -- smear_between_neighbor_lines = true,

      -- Use floating windows to display smears over wrapped lines or outside buffers.
      -- May have performance issues with other plugins.
      use_floating_windows = false,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      -- legacy_computing_symbols_support = false,
    },
  },
  { "sitiom/nvim-numbertoggle", event = "BufEnter" },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "tomiis4/Hypersonic.nvim",
    event = "CmdlineEnter",
    cmd = "Hypersonic",
    config = function()
      require("hypersonic").setup({
        -- config
      })
    end,
  },
  -- Sets yaml indentation wrong - guess indent fixes
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "volskaya/windovigation.nvim",
    lazy = false,
    opts = {},
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = true,
  --   -- use opts = {} for passing setup options
  --   -- this is equivalent to setup({}) function
  -- },
  -- { "windwp/nvim-ts-autotag", event = "InsertEnter" },
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
