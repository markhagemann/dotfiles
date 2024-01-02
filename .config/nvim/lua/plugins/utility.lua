return {
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufLeave" },
    opts = {
      events = { "BufLeave" },
      silent = true,
      exclude_ft = { "nvim-tree" },
    },
  },
  {
    "AckslD/muren.nvim",
    event = { "BufEnter" },
    config = true,
  },
  { "APZelos/blamer.nvim",     event = { "BufEnter" } },
  { "arthurxavierx/vim-caser", event = "BufEnter" },
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
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        }
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  { "folke/todo-comments.nvim",                    event = { "BufEnter" } },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufEnter" },
  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
    config = function()
      require("neoscroll").setup({})
    end,
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
    config = function()
      require("spaceless").setup()
    end,
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
    dependencies = "catppuccin/nvim",
  },
  { "NvChad/nvim-colorizer.lua", event = "BufEnter" },
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
  {
    "petertriho/nvim-scrollbar",
    event = "BufEnter",
    config = function()
      require("scrollbar").setup({
        handlers = {
          cursor = false,
          diagnostic = true,
          gitsigns = false,
          handle = true,
          search = false,
          ale = false,
        },
      })
    end,
  },
  { "sitiom/nvim-numbertoggle",  event = "BufEnter" },
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>h", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<M-q>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<M-e>", function()
        harpoon:list():next()
      end)
    end,
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
}
