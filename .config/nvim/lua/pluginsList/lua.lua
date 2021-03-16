-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        -- Package Manager
        use {"wbthomason/packer.nvim", opt = true}
        -- Colorscheme
        use {"ayu-theme/ayu-vim"}
        use {"norcalli/nvim-colorizer.lua"}
        -- Debugging
        use {"mfussenegger/nvim-dap"}
        -- File manager
        use {"kyazdani42/nvim-web-devicons"}
        use {"kyazdani42/nvim-tree.lua"}
        -- File searching and replacing
        use {"brooth/far.vim"}
        -- Fuzzy finder
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        -- Git
        use {"APZelos/blamer.nvim"}
        use {"nvim-lua/plenary.nvim"}
        use {"lewis6991/gitsigns.nvim"}
        -- Line indent
        use {"lukas-reineke/indent-blankline.nvim"}
        use { 'Yggdroot/indentLine'}
        -- LSP
        use {"tpope/vim-sleuth"}
        use {"sbdchd/neoformat"}
        use {"neovim/nvim-lspconfig"}
        use {"glepnir/lspsaga.nvim"}
        use {"hrsh7th/nvim-compe"}
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}
        use {"tweekmonster/startuptime.vim"}
        use {"onsails/lspkind-nvim"}
        use {"nvim-treesitter/nvim-treesitter"}
        use {"elzr/vim-json"}
        use {"plasticboy/vim-markdown"}
        use {"joukevandermaas/vim-ember-hbs"}
        -- Popup
        use {"nvim-lua/popup.nvim"}
        use {"voldikss/vim-floaterm"}
        -- Scratchpad
        use {"Konfekt/vim-scratchpad"}
        -- Statusline
        use {"glepnir/galaxyline.nvim"}
        -- Whitespace trim
        use {"ntpeters/vim-better-whitespace"}
        -- Word manipulation
        use {"tpope/vim-commentary"}
        use {"chaoren/vim-wordmotion"}
    end
)
