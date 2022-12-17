local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
})

packer.startup(function(use)
  -- Defaults / Essentials
  use("wbthomason/packer.nvim") -- Packer manages itself
  use("nvim-lua/plenary.nvim") -- Avoids callbacks, used by other plugins
  use("nvim-lua/popup.nvim") -- Popup for other plugins
  use("rcarriga/nvim-notify") -- Popup notifications
  use("nvim-treesitter/nvim-treesitter") -- Language parsing completion engine
  use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })

  -- LSP
  use({ "williamboman/mason.nvim", commit = "bfc5997e52fe9e20642704da050c415ea1d4775f" })
  use({ "williamboman/mason-lspconfig.nvim", commit = "0eb7cfefbd3a87308c1875c05c3f3abac22d367c" })
  use({ "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }) -- enable LSP
  use({ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }) -- for formatters and linters
  use("MunifTanjim/prettier.nvim")
  use({ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" })
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })
  use("folke/lsp-colors.nvim")
  use("onsails/lspkind.nvim")
  use("j-hui/fidget.nvim")
  use({
    "m-demare/hlargs.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
  })

  -- Completion
  use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
  use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
  use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

  -- snippets
  use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }) --snippet engine
  use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use

  -- Debugging
  use({ "mfussenegger/nvim-dap", commit = "6b12294a57001d994022df8acbe2ef7327d30587" })
  use({ "rcarriga/nvim-dap-ui", commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" })
  use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

  -- File Explorer / Search
  use({ "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" })
  use({ "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" })
  use({ "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({
    "windwp/nvim-spectre",
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" })

  -- Terminal
  use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })

  -- Theme
  use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" })

  -- Utility
  use({ "stevearc/dressing.nvim", requires = "MunifTanjim/nui.nvim" })
  use({ "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" })
  use({ "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" }) -- Autopairs, integrates with both cmp and treesitter
  use("windwp/nvim-ts-autotag")
  use({ "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" })
  use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })
  use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }) -- Indent support (including blank lines)
  use({ "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" })
  use("edluffy/specs.nvim")
  use("arthurxavierx/vim-caser")
  use("tpope/vim-sleuth")
  use("tpope/vim-abolish")
  use("echasnovski/mini.surround")
  use("folke/trouble.nvim")
  use("folke/which-key.nvim")
  use("karb94/neoscroll.nvim")
  use({ "NvChad/nvim-colorizer.lua" })
  use("sitiom/nvim-numbertoggle")
  use("chaoren/vim-wordmotion")
  use("christoomey/vim-tmux-navigator")
  use({
    "lewis6991/spaceless.nvim",
    config = function()
      require("spaceless").setup()
    end,
  })
  use({ "antoinemadec/FixCursorHold.nvim" })
  use({
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_leader = ";"
    end,
  })
  use({ "folke/zen-mode.nvim" })
  use({
    "sunjon/shade.nvim",
    config = function()
      require("shade").setup()
      require("shade").toggle()
    end,
  })

  -- Automaticallr set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
