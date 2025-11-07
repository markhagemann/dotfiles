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
        desc = "Git blame",
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
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (trouble)" },
    },
    opts = {},
  },
  {
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
    "kburdett/vim-nuuid",
    keys = {
      { "<leader>uu", "<Plug>Nuuid", desc = "Generate uuid" },
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
      { "<leader>ut", ":UndotreeToggle<cr>", desc = "Toggle undo tree" },
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
      vim.keymap.set("n", "<Tab>g", vim.cmd.GuessIndent, { desc = "Guessindent (manual)" })
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
  {
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
  {
    "r0nsha/multinput.nvim",
    event = "BufEnter",
    opts = {},
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
  {
    "SyedAsimShah1/quick-todo.nvim",
    keys = {
      {
        "<leader>tt",
        "<cmd>lua require('quick-todo').open_todo()<CR>",
        mode = { "n" },
        silent = true,
        desc = "Toggle todo",
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
  },
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
      local opts = { noremap = true, silent = true, desc = "Pick colour" }
      vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<cr>", opts)
      require("color-picker").setup({
        ["icons"] = { "-", "" },
      })
    end,
  },
}
