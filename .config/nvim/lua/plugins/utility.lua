return {
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufLeave" },
    opts = {
      events = { "BufLeave" },
      silent = false,
      exclude_ft = { "neo-tree" },
    },
  },
  { "APZelos/blamer.nvim", event = { "BufEnter" } },
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
  { "chaoren/vim-wordmotion", event = { "BufEnter" } },
  {
    "AckslD/muren.nvim",
    event = { "BufEnter" },
    config = true,
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
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufEnter" },
  { "kburdett/vim-nuuid", event = "InsertEnter" },
  {
    "lewis6991/spaceless.nvim",
    event = { "BufLeave", "InsertEnter" },
    config = function()
      require("spaceless").setup()
    end,
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, event = "BufEnter" },
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    lazy = false,
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)
    end,
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
}
