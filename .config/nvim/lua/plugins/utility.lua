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
  { "code-biscuits/nvim-biscuits", event = "BufEnter", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "danilamihailov/beacon.nvim",
    event = "BufEnter",
    opts = {
      fps = 60, --- integer how smooth the animation going to be
      speed = 1, --- integer speed at wich animation goes
      width = 10, --- integer width of the beacon window
      window_events = { "WinEnter", "FocusGained" }, -- table<string> what events trigger cursor highlight
      winblend = 5, --- integer starting transparency of beacon window :h winblend
      highlight = { bg = "#5f87cd", ctermbg = 14 }, -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  { "echasnovski/mini.animate", version = "*", event = "BufEnter" },
  { "echasnovski/mini.hipatterns", version = "*", event = "BufEnter" },
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
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
      routes = {
        {
          view = "notify",
          filter = {
            event = "msg_showmode",
            any = {
              { find = "recording" },
            },
          },
        },
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
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
  -- Waiting on RNU support
  -- {
  --   "JuanBaut/statuscolumn.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   lazy = false,
  --   config = function()
  --     require("statuscolumn").setup({
  --       gradient_hl = "Special",
  --     })
  --   end,
  -- },
  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
    opts = {},
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
      { "<leader>qn", ":cnext<cr>", desc = "[q]uickfix [n]ext" },
      { "<leader>qp", ":cprevious<cr>", desc = "[q]uickfix [p]revious" },
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
      scope = { enabled = false, show_start = false, show_end = false },
    },
    event = "BufEnter",
  },
  {
    "m4xshen/hardtime.nvim",
    event = "BufEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
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
        desc = "[s]earch & [r]eplace across all files (Grug)",
      },
      {
        "<leader>sc",
        "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand(' % ') } })<cr>",
        desc = "[s]earch & Replace across [c]urrent file (Grug)",
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
      { "<leader>ut", ":UndotreeToggle<cr>", desc = "[u]ndo [t]ree" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = function()
      require("colorizer").setup({})
    end,
  },
  -- {
  --   "nvim-pack/nvim-spectre",
  --   build = false,
  --   cmd = "Spectre",
  --   opts = { open_cmd = "noswapfile vnew" },
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>sr", function() require("spectre").open() end, desc = "[S]earch & [R]eplace in files (Spectre)" },
  --   },
  -- },
  {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = "<leader>;", -- Recommended to be a single key
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
  -- scrolloff_percentage: controls how close the cursor can be to the top or bottom
  --                       of the screen before scrolling begins
  {
    "tonymajestro/smart-scrolloff.nvim",
    opts = {
      scrolloff_percentage = 0.2,
    },
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
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
      local opts = { noremap = true, silent = true, desc = "[p]ick [c]olour" }
      vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<cr>", opts)
      require("color-picker").setup({
        ["icons"] = { "-", "" },
      })
    end,
  },
}
