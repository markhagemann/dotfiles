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
    event = { "BufLeave" },
    config = function()
      require("autosave").setup({
        events = { "BufLeave" },
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "AckslD/muren.nvim",
    event = { "BufEnter" },
    config = true,
  },
  { "arthurxavierx/vim-caser",     event = "BufEnter" },
  {
    "christoomey/vim-tmux-navigator",
    event = { "BufEnter" },
    keys = {
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Go to the previous pane" },
      { "<C-h>",  "<cmd>TmuxNavigateLeft<cr>",     desc = "Go to the left pane" },
      { "<C-j>",  "<cmd>TmuxNavigateDown<cr>",     desc = "Go to the down pane" },
      { "<C-k>",  "<cmd>TmuxNavigateUp<cr>",       desc = "Go to the up pane" },
      { "<C-l>",  "<cmd>TmuxNavigateRight<cr>",    desc = "Go to the right pane" },
    },
  },
  { "chaoren/vim-wordmotion",      event = { "BufEnter" } },
  { "code-biscuits/nvim-biscuits", event = { "BufEnter" }, dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  { "echasnovski/mini.animate",     version = "*", event = { "BufEnter" } },
  { "echasnovski/mini.hipatterns",  version = "*", event = { "BufEnter" } },
  { "echasnovski/mini.indentscope", version = "*", event = { "BufEnter" } },
  {
    "echasnovski/mini.surround",
    event = { "BufEnter" },
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
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
        "<CMD>ToggleBlame<CR>",
        desc = "Open git blame list",
        noremap = true,
        silent = true,
      },
    },
    config = function(_, opts)
      require("blame").setup(opts)
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       hover = {
  --         enabled = false,
  --       },
  --       presets = {
  --         -- bottom_search = true,   -- use a classic bottom cmdline for search
  --         -- command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         -- inc_rename = false,     -- enables an input dialog for inc-rename.nvim
  --         -- lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --       signature = {
  --         enabled = false,
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   config = function(_, opts)
  --     vim.api.nvim_set_keymap("n", "<leader>cn", ":NoiceDismiss<CR>", { noremap = true })
  --     require("noice").setup(opts)
  --   end,
  -- },
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
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {},
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
  {
    "j-hui/fidget.nvim",
    event = "BufEnter",
    opts = {
      notification = {
        window = {
          normal_hl = "Comment", -- Base highlight group in the notification window
          winblend = 0,    -- Background color opacity in the notification window
          border = "none",   -- Border around the notification window
          zindex = 45,       -- Stacking priority of the notification window
          max_width = 0,     -- Maximum width of the notification window
          max_height = 0,    -- Maximum height of the notification window
          x_padding = 1,     -- Padding from right edge of window boundary
          y_padding = 0,     -- Padding from bottom edge of window boundary
          align = "bottom",  -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
        },
      },
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufEnter" },
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
    "lewis6991/spaceless.nvim",
    event = { "BufLeave", "InsertEnter" },
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = true, show_start = false, show_end = false },
    },
    event = "BufEnter",
  },
  {
    "mawkler/modicator.nvim",
    event = "VeryLazy",
    dependencies = "catppuccin/nvim",
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = function()
      require("colorizer").setup({})
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    event = { "BufEnter" },
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  { "sitiom/nvim-numbertoggle",                    event = "BufEnter" },
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
