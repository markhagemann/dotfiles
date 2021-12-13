local packer = require("util.packer")

local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
  -- list of plugins that should be taken from ~/projects
  -- this is NOT packer functionality!
  local_plugins = {},
}

local function plugins(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", opt = true })

  -- LSP
  use({ "tpope/vim-sleuth" })

  use({
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    wants = {
      "nvim-lsp-ts-utils",
      "lua-dev.nvim",
      "cmp-nvim-lsp",
      "e-kaput.nvim",
      "nvim-lsp-installer",
    },
    config = function()
      require("config.lsp")
    end,
    requires = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "folke/lua-dev.nvim",
      "kaputi/e-kaput.nvim",
      "williamboman/nvim-lsp-installer",
    },
  })
  use({ -- Support for non-LSP stuff via LSP (configured in LSP)
    "jose-elias-alvarez/null-ls.nvim",
    branch = "main",
  })

  use({ "joukevandermaas/vim-ember-hbs" })
  use({ "hashivim/vim-terraform" })

  use({ "ray-x/lsp_signature.nvim" })

  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.compe")
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "David-Kunz/cmp-npm",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require("config.snippets")
        end,
      },
      "rafamadriz/friendly-snippets",
      {
        "windwp/nvim-autopairs",
        config = function()
          require("config.autopairs")
        end,
      },
    },
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
  })

  use({
    "b3nj5m1n/kommentary",
    opt = true,
    wants = "nvim-ts-context-commentstring",
    keys = { "<C-_>", "gc", "gcc" },
    config = function()
      require("config.comments")
    end,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    requires = {
      { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = [[require('config.treesitter')]],
  })

  -- Debugging
  use({
    "mfussenegger/nvim-dap",
    wants = { "mfussenegger/nvim-lua-debugger", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require("config.dap")
    end,
    requires = {
      "mfussenegger/nvim-lua-debugger",
      "theHamsta/nvim-dap-virtual-text",
    },
  })

  -- File Manager
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeClose" },
    config = function()
      require("config.tree")
    end,
  })

  -- Theme: color schemes
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("config.theme")
    end,
  })

  -- Theme: icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("terminal").setup()
    end,
  })

  use({ "nvim-lua/plenary.nvim", module = "plenary" })

  use({ "nvim-lua/popup.nvim", module = "popup" })

  -- Fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    keys = { "<C-p>" },
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-z.nvim",
      "telescope-project.nvim",
      "trouble.nvim",
      "telescope-symbols.nvim",
    },
    requires = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Indent Guides and rainbow brackets
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.blankline")
    end,
  })

  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    keys = "<M-`>",
    config = function()
      require("config.terminal")
    end,
  })

  -- Scratchpad
  use({ "Konfekt/vim-scratchpad" })

  -- Search and replace
  use({
    "windwp/nvim-spectre",
    opt = true,
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  })

  use({
    "VonHeikemen/searchbox.nvim",
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("config.searchbox")
    end,
  })

  -- Smooth Scrolling
  use({
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = function()
      require("config.scroll")
    end,
  })

  use({
    "edluffy/specs.nvim",
    after = "neoscroll.nvim",
    config = function()
      require("config.specs")
    end,
  })

  -- Git
  use({
    "APZelos/blamer.nvim",
    config = function()
      require("config.blamer")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })

  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("config.neogit")
    end,
  })

  -- Statusline
  use({
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = [[require('config.lualine')]],
    wants = "nvim-web-devicons",
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("config.colorizer")
    end,
  })

  use({ "npxbr/glow.nvim", cmd = "Glow" })

  use({
    "plasticboy/vim-markdown",
    opt = true,
    requires = "godlygeek/tabular",
    ft = "markdown",
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  })

  -- Utility
  use({
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup()
    end,
  })

  use({
    "sayanarijit/exec-cursorline-insert-stdout.nvim",
  })

  use({
    "phaazon/hop.nvim",
    keys = { "gh" },
    cmd = { "HopWord", "HopChar1" },
    config = function()
      require("util").nmap("gh", "<cmd>HopWord<CR>")
      -- require("util").nmap("s", "<cmd>HopChar1<CR>")
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({})
    end,
  })

  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({ auto_open = false, auto_preview = false, mode = "lsp_document_diagnostics" })
    end,
  })

  use({
    "folke/persistence.nvim",
    event = "VimEnter",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })

  use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })
  use({
    "tpope/vim-abolish",
    event = "BufReadPre",
  })
  use({
    "chaoren/vim-wordmotion",
    event = "BufReadPre",
  })

  use({ "mbbill/undotree", cmd = "UndotreeToggle" })

  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    wants = "twilight.nvim",
    requires = { "folke/twilight.nvim" },
    config = function()
      require("zen-mode").setup({
        plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
      })
    end,
  })

  use({
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = function()
      require("config.todo")
    end,
  })

  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
    end,
  })

  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("config.diffview")
    end,
  })

  use({
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  })

  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  })
end

return packer.setup(config, plugins)
