local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
end
vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, "packer")

if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
        prompt_border = "single",
    },
    git = {
        clone_timeout = 600,
    },
    auto_clean = true,
    compile_on_sync = false,
}

return packer.startup(function(use)
    use { "wbthomason/packer.nvim" }

    -- Syntax
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "windwp/nvim-ts-autotag",
            "p00f/nvim-ts-rainbow",
            "SmiteshP/nvim-gps",
        },
        run = ":TSUpdate",
        config = require "plugins.configs.treesitter",
    }

    -- UI
    use({
        "folke/tokyonight.nvim",
        config = require "theme",
    })
    use { "kyazdani42/nvim-web-devicons" }
    use {
        "nvim-lualine/lualine.nvim",
        config = require "plugins.configs.lualine",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    use { "folke/which-key.nvim" }
    use { "karb94/neoscroll.nvim", config = require "plugins.configs.neoscroll" }

    -- Utilities
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = require "plugins.configs.nvimtree",
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-node-modules.nvim",
        },
        config = require "plugins.configs.telescope",
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "lukas-reineke/indent-blankline.nvim", config = require "plugins.configs.indent" }
    use { "windwp/nvim-autopairs", config = require "plugins.configs.autopairs" }
    use { "tpope/vim-surround" }
    use { "norcalli/nvim-colorizer.lua", config = require "plugins.configs.colorizer" }

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},
          {'williamboman/nvim-lsp-installer'},
      
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},
      
          -- Snippets
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
        }
    }

    -- -- Comment
    use { "numToStr/Comment.nvim", config = require "plugins.configs.comment" }

    -- Tmux
    use { "aserowy/tmux.nvim", config = require "plugins.configs.tmux" }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = require "plugins.configs.gitsigns",
    }

    -- Markdown
    use {
        "davidgranstrom/nvim-markdown-preview",
        config = function()
            vim.g.nvim_markdown_preview_format = "gfm"
            vim.g.nvim_markdown_preview_theme = "github"
        end,
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
