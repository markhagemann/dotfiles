local fn = vim.fn
-- Automatically install packer on initial startup
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_Bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print "---------------------------------------------------------"
  print "Press Enter to install packer and plugins."
  print "After install -- close and reopen Neovim to load configs!"
  print "---------------------------------------------------------"
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call
local present, packer = pcall(require, "packer")

if not present then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.startup(function(use)
  -- Defaults / Essentials
  use 'wbthomason/packer.nvim'             -- Packer manages itself 
  use 'nvim-lua/plenary.nvim'              -- Avoids callbacks, used by other plugins
  use 'nvim-lua/popup.nvim'                -- Popup for other plugins
  use 'nvim-treesitter/nvim-treesitter'    -- Language parsing completion engine
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }

  -- LSP 
  use "williamboman/mason.nvim"            -- UI for fetching/downloading LSPs
  use "williamboman/mason-lspconfig.nvim"  -- Bridges mason and lspconfig
  use 'neovim/nvim-lspconfig'              -- Language server protocol implementation
  use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- For formatters and linters
  use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }

  -- Completion
  use 'hrsh7th/nvim-cmp'                   -- Vim completion engine
  use 'L3MON4D3/LuaSnip'                   -- More snippets
  use 'saadparwaiz1/cmp_luasnip'           -- Even more snippets
  use 'hrsh7th/cmp-nvim-lsp'               -- Cmp's own LSP
  use 'hrsh7th/cmp-nvim-lua'               -- Cmp source for lua
  use 'hrsh7th/cmp-buffer'                 -- Cmp source for buffer words
  use 'hrsh7th/cmp-path'                   -- Cmp source for path words

  -- Debugging 
  use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- File Explorer / Search
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
  use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" }
  use 'nvim-telescope/telescope.nvim'      -- Finder, requires fzf and ripgrep
  use({
    "windwp/nvim-spectre",
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  })

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" }

  -- Terminal
  use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" }

  -- Theme
  use 'lunarvim/darkplus.nvim'
  use 'gruvbox-community/gruvbox'
  use 'olivercederborg/poimandres.nvim'

  -- Utility
  use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" } -- Statusline 
  use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" } -- Commenting support
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" } -- Improve NeoVim startup time
  use { "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" } -- Indent support (including blank lines)
  use 'edluffy/specs.nvim'
  use 'tpope/vim-abolish'
  use 'folke/lsp-colors.nvim'
  use 'folke/trouble.nvim'
  use 'folke/which-key.nvim'
  use 'karb94/neoscroll.nvim'
  use 'norcalli/nvim-colorizer.lua'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_Bootstrap then
    require('packer').sync()
  end
end)

