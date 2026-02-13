return {
  {
    -- Seamless navigation between Neovim and tmux panes
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
        desc = "Navigate left",
      },
      {
        "<C-j>",
        function()
          require("tmux").move_top()
        end,
        desc = "Navigate top",
      },
      {
        "<C-k>",
        function()
          require("tmux").move_top()
        end,
        desc = "Navigate top",
      },
      {
        "<C-l>",
        function()
          require("tmux").move_right()
        end,
        desc = "Navigate right",
      },
    },
  },
  -- Change case of text (camelCase, snake_case, etc.)
  -- Keybindings (follow with motion/text object or use in visual mode):
  --   gsc    - Convert to camelCase
  --   gs_    - Convert to snake_case
  --   gs- / gsk - Convert to kebab-case / dash-case
  --   gsm / gsp - Convert to MixedCase / PascalCase
  --   gsu / gsU - Convert to UPPER_CASE
  --   gst    - Convert to Title Case
  --   gss    - Convert to Sentence case
  --   gs<space> - Convert to space case
  --   gsK    - Convert to Title-Dash-Case / Title-Kebab-Case
  --   gs.    - Convert to dot.case
  { "arthurxavierx/vim-caser", event = "BufEnter" },
  {
    -- Display import/require statement sizes for JavaScript/TypeScript
    "barrett-ruth/import-cost.nvim",
    event = "BufEnter",
    build = "sh install.sh yarn",
    -- if on windows
    -- build = 'pwsh install.ps1 yarn',
    config = function()
      vim.g.import_cost = {
        package_manager = "yarn",
      }
    end,
  },
  {
    -- Navigate through edit history and jump to previous edits
    "bloznelis/before.nvim",
    event = "BufEnter",
    config = function()
      local before = require("before")
      before.setup()

      -- Jump to previous entry in the edit history
      vim.keymap.set("n", "<leader>jl", before.jump_to_last_edit, { desc = "Jump to last edit" })

      -- Jump to next entry in the edit history
      vim.keymap.set("n", "<leader>jn", before.jump_to_next_edit, { desc = "Jump to next edit" })

      -- Look for previous edits in quickfix list
      vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, { desc = "Open edits in quickfix" })

      -- Look for previous edits in telescope (needs telescope, obviously)
      -- vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, { desc = "Open edits in telescope" })
    end,
  },
  {
    -- Enhanced word motion (w, e, b) that stops at subword boundaries
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
    -- Git blame information displayed in a floating window
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end,
    keys = {
      {
        "<leader>gb",
        "<CMD>BlameToggle<CR>",
        desc = "Git blame",
        noremap = true,
        silent = true,
      },
    },
  },
  {
    -- Quickfix list and diagnostics viewer with better UI
    "folke/trouble.nvim",
    cmd = { "TodoTrouble", "TroubleToggle" },
    event = "VimEnter",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (trouble)" },
    },
    opts = {},
  },
  {
    -- Automatic session management for Neovim
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      autoload = true,
      autosave = true,
      use_git_branch = true,
    },
    config = function(_, opts)
      local persisted = require("persisted")
      persisted.branch = function()
        local branch = vim.fn.systemlist("git branch --show-current")[1]
        return vim.v.shell_error == 0 and branch or nil
      end
      persisted.setup(opts)
    end,
  },
  {
    -- Generate UUIDs and insert them at cursor position
    "kburdett/vim-nuuid",
    keys = {
      { "<leader>uu", "<Plug>Nuuid", desc = "Generate uuid" },
    },
  },
  {
    -- Remove trailing whitespace automatically
    "lewis6991/spaceless.nvim",
    event = { "BufLeave", "InsertEnter" },
    opts = {},
  },
  {
    -- Training mode that prevents bad vim habits and enforces good practices
    "m4xshen/hardtime.nvim",
    event = "BufEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "aerial",
        "alpha",
        "checkhealth",
        "copilot-chat",
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
      timeout = 500,
    },
  },
  {
    -- Find and replace across files with preview
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
    end,
    keys = {
      {
        "<leader>sr",
        ":GrugFar<cr>",
        desc = "Search/replace across all files (grug)",
      },
      {
        "<leader>sc",
        "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand(' % ') } })<cr>",
        desc = "Search/replace across current file (grug)",
      },
    },
  },
  {
    -- Better escape from insert mode using jk or kj
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
  -- Intercepts p / P / gp / gP so linewise pasted code lands at the right indent level automatically.
  {
    "nemanjamalesija/smart-paste.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    -- Automatically detect and set indentation settings for files
    "nmac427/guess-indent.nvim",
    event = "BufEnter",
    config = function()
      require("guess-indent").setup({
        auto_cmd = false, -- Set to false to disable automatic execution
      })
      vim.cmd([[ autocmd BufReadPost * :silent GuessIndent ]])
      vim.keymap.set("n", "<Tab>g", vim.cmd.GuessIndent, { desc = "Guessindent (manual)" })
    end,
  },
  -- {
  --   -- Create and navigate bookmarks in your code
  --   "otavioschwanck/arrow.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     show_icons = true,
  --     leader_key = ";", -- Recommended to be a single key
  --   },
  -- },
  -- { "preservim/vim-pencil", event = "VeryLazy" },
  {
    -- Toggle Neovim window fullscreen mode
    "propet/toggle-fullscreen.nvim",
    keys = {
      {
        "<leader>wf",
        function()
          require("toggle-fullscreen"):toggle_fullscreen()
        end,
        desc = "Toggle window fullscreen",
      },
    },
  },
  -- Automatically between relative and absolute line numbers depending on mode
  { "sitiom/nvim-numbertoggle", event = "BufEnter" },
  {
    -- Quickfix list improvements with better navigation
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  -- {
  --   -- Quick todo list management in Neovim
  --   "SyedAsimShah1/quick-todo.nvim",
  --   keys = {
  --     {
  --       "<leader>tt",
  --       "<cmd>lua require('quick-todo').open_todo()<CR>",
  --       mode = { "n" },
  --       silent = true,
  --       desc = "Toggle todo",
  --     },
  --   },
  --   config = function()
  --     require("quick-todo").setup({
  --       window = {
  --         height = 0.5,
  --         width = 0.5,
  --         winblend = 0,
  --         border = "rounded",
  --       },
  --     })
  --   end,
  -- },
  -- Sets yaml indentation wrong - guess indent fixes
  -- Automatically adjust shiftwidth and expandtab based on existing file
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- {
  --   "volskaya/windovigation.nvim",
  --   lazy = false,
  --   opts = {},
  -- },
  -- Automatically close and rename HTML/JSX tags
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    -- Undo tree visualizer for better undo navigation
    "XXiaoA/atone.nvim",
    opts = {},
    keys = {
      {
        "<leader>ut",
        "<cmd>Atone<cr>",
        desc = "Toggle Undo Tree",
      },
    },
  },
  {
    -- Color picker for selecting and inserting color codes
    "ziontee113/color-picker.nvim",
    event = "BufEnter",
    config = function()
      local opts = { noremap = true, silent = true, desc = "Pick colour" }
      vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<cr>", opts)
      require("color-picker").setup({
        ["icons"] = { "-", "" },
      })
    end,
  },
}
