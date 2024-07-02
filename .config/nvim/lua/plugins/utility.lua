return {
  -- {
  --   "3rd/image.nvim",
  --   event = { "BufEnter" },
  --   config = function()
  --     require("image").setup({})
  --   end,
  -- },
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
    "bloznelis/before.nvim",
    event = { "BufEnter" },
    config = function()
      local before = require("before")
      before.setup()

      -- Jump to previous entry in the edit history
      vim.keymap.set("n", "<leader>jl", before.jump_to_last_edit, { desc = "[J]ump to [L]ast Edit" })

      -- Jump to next entry in the edit history
      vim.keymap.set("n", "<leader>jn", before.jump_to_next_edit, { desc = "Jump to [N]ext Edit" })

      -- Look for previous edits in quickfix list
      vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, { desc = "[O]pen Edits in [Q]uickfix" })

      -- Look for previous edits in telescope (needs telescope, obviously)
      vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, { desc = "[O]pen [E]dits in Telescope" })
    end,
  },
  { "arthurxavierx/vim-caser", event = "BufEnter" },
  {
    "christoomey/vim-tmux-navigator",
    event = { "BufEnter" },
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
  { "code-biscuits/nvim-biscuits", event = { "BufEnter" }, dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  { "echasnovski/mini.animate", version = "*", event = { "BufEnter" } },
  { "echasnovski/mini.hipatterns", version = "*", event = { "BufEnter" } },
  { "echasnovski/mini.indentscope", version = "*", event = { "BufEnter" } },
  {
    "echasnovski/mini.surround",
    event = { "BufEnter" },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
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
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        hover = {
          enabled = false,
        },
        presets = {
          -- bottom_search = true,   -- use a classic bottom cmdline for search
          -- command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          -- inc_rename = false,     -- enables an input dialog for inc-rename.nvim
          -- lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        signature = {
          enabled = false,
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          timeout = 1000,
          render = "compact",
          stages = "fade",
          top_down = false,
          on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
          end,
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_set_keymap("n", "<leader>nd", ":NoiceDismiss<CR>", { desc = "[D]ismiss [N]oice", noremap = true })
      require("noice").setup(opts)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- NOTE: https://github.com/LazyVim/LazyVim/discussions/1583
    event = "VimEnter",
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*[:@]\s*]], -- vim regex
      },
      search = {
        -- Matches with "TODO: something" and "TODO @PL something"
        pattern = [[\b(KEYWORDS)\s*[:@]\b]], -- ripgrep regex
      },
    },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
  },
  {
    "gbprod/cutlass.nvim",
    event = "BufEnter",
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
  -- {
  --   "j-hui/fidget.nvim",
  --   event = "BufEnter",
  --   opts = {
  --     notification = {
  --       window = {
  --         normal_hl = "Comment", -- Base highlight group in the notification window
  --         winblend = 0, -- Background color opacity in the notification window
  --         border = "none", -- Border around the notification window
  --         zindex = 45, -- Stacking priority of the notification window
  --         max_width = 0, -- Maximum width of the notification window
  --         max_height = 0, -- Maximum height of the notification window
  --         x_padding = 1, -- Padding from right edge of window boundary
  --         y_padding = 0, -- Padding from bottom edge of window boundary
  --         align = "bottom", -- How to align the notification window
  --         relative = "editor", -- What the notification window position is relative to
  --       },
  --     },
  --   },
  -- },
  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
    opts = {},
  },
  {
    "kburdett/vim-nuuid",
    keys = {
      { "<leader>uu", "<Plug>Nuuid", desc = "Create New UUID" },
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
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = true, show_start = false, show_end = false },
    },
    event = "BufEnter",
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = function()
      require("colorizer").setup({})
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "[S]earch & [R]eplace in files (Spectre)" },
    },
  },
  { "sitiom/nvim-numbertoggle", event = "BufEnter" },
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
  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    opts = {
      delay = 200,
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
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = "<leader>;", -- Recommended to be a single key
    },
  },
  -- { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" }, opts = {},
  --   event = "VeryLazy",
  --   config = function()
  --     local harpoon = require("harpoon")
  --
  --     harpoon:setup()
  --
  --     vim.keymap.set("n", "<leader>h", function()
  --       harpoon:list():append()
  --     end)
  --     vim.keymap.set("n", "<C-e>", function()
  --       harpoon.ui:toggle_quick_menu(harpoon:list())
  --     end)
  --     -- Toggle previous & next buffers stored within Harpoon list
  --     vim.keymap.set("n", "<M-q>", function()
  --       harpoon:list():prev()
  --     end)
  --     vim.keymap.set("n", "<M-e>", function()
  --       harpoon:list():next()
  --     end)
  --   end,
  -- },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- {
  --   "tris203/precognition.nvim",
  --   event = "VeryLazy",
  --   config = {
  --     -- startVisible = true,
  --     -- showBlankVirtLine = true,
  --     -- highlightColor = { link = "Comment" },
  --     hints = {
  --       -- Hide the following with prio 0
  --       w = { text = "w", prio = 0 },
  --       b = { text = "b", prio = 0 },
  --       e = { text = "e", prio = 0 },
  --       -- Caret = { text = "^", prio = 2 },
  --       -- Dollar = { text = "$", prio = 1 },
  --       -- MatchingPair = { text = "%", prio = 5 },
  --       -- Zero = { text = "0", prio = 1 },
  --       -- W = { text = "W", prio = 7 },
  --       -- B = { text = "B", prio = 6 },
  --       -- E = { text = "E", prio = 5 },
  --     },
  --     -- gutterHints = {
  --     --     G = { text = "G", prio = 10 },
  --     --     gg = { text = "gg", prio = 9 },
  --     --     PrevParagraph = { text = "{", prio = 8 },
  --     --     NextParagraph = { text = "}", prio = 8 },
  --     -- },
  --   },
  -- },
  {
    "volskaya/windovigation.nvim",
    lazy = false,
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "ziontee113/color-picker.nvim",
    event = "BufEnter",
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>cc", "<cmd>PickColor<cr>", opts)
      require("color-picker").setup({
        ["icons"] = { "-", "" },
      })
    end,
  },
}
