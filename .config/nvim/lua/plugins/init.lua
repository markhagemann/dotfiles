local fn = vim.fn
-- Automatically install packer on initial startup
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_Bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("---------------------------------------------------------")
	print("Press Enter to install packer and plugins.")
	print("After install -- close and reopen Neovim to load configs!")
	print("---------------------------------------------------------")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call
local present, packer = pcall(require, "packer")

if not present then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup(function(use)
	-- Defaults / Essentials
	use("wbthomason/packer.nvim") -- Packer manages itself
	use("nvim-lua/plenary.nvim") -- Avoids callbacks, used by other plugins
	use("nvim-lua/popup.nvim") -- Popup for other plugins
	use("nvim-treesitter/nvim-treesitter") -- Language parsing completion engine
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })

	-- LSP
	use("williamboman/mason.nvim") -- UI for fetching/downloading LSPs
	use("williamboman/mason-lspconfig.nvim") -- Bridges mason and lspconfig
	use("neovim/nvim-lspconfig") -- Language server protocol implementation
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "07d4ed4c6b561914aafd787453a685598bec510f" }) -- For formatters and linters
	use("MunifTanjim/prettier.nvim")
	use({ "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" })
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use("folke/lsp-colors.nvim")
	use("onsails/lspkind.nvim")

	-- Completion
	use({ "hrsh7th/nvim-cmp", commit = "aee40113c2ba3ab158955f233ca083ca9958d6f8" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "78924d1d677b29b3d1fe429864185341724ee5a2" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

	-- Debugging
	use({ "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" })
	use({ "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

	-- File Explorer / Search
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	use({ "kyazdani42/nvim-tree.lua", commit = "cf908370fb046641e3aaaa6a6177c1b5d165f186" })
	use("nvim-telescope/telescope.nvim") -- Finder, requires fzf and ripgrep
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"windwp/nvim-spectre",
		module = "spectre",
		wants = { "plenary.nvim", "popup.nvim" },
		requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "9ff7dfb051e5104088ff80556203634fc8f8546d" })

	-- Terminal
	use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })

	-- Theme
	use("folke/tokyonight.nvim")
	use("lunarvim/darkplus.nvim")
	use("gruvbox-community/gruvbox")
	use("olivercederborg/poimandres.nvim")

	-- Utility
	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" }) -- Statusline
	use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
	use("windwp/nvim-ts-autotag")
	use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }) -- Commenting support
	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }) -- Improve NeoVim startup time
	use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }) -- Indent support (including blank lines)
	use("edluffy/specs.nvim")
	use("arthurxavierx/vim-caser")
	use("tpope/vim-sleuth")
	use("folke/trouble.nvim")
	use("folke/which-key.nvim")
	use("karb94/neoscroll.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("chaoren/vim-wordmotion")
	use("christoomey/vim-tmux-navigator")
	use({
		"lewis6991/spaceless.nvim",
		config = function()
			require("spaceless").setup()
		end,
	})

	-- Automaticallr set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if Packer_Bootstrap then
		require("packer").sync()
	end
end)
