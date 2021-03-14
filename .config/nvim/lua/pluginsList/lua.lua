-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}
        use {"kyazdani42/nvim-web-devicons"}
        use {"kyazdani42/nvim-tree.lua"}
        use {"nvim-lua/plenary.nvim"}
        use {"lewis6991/gitsigns.nvim"}
        use {"glepnir/galaxyline.nvim"}
        use {"sinetoami/lightline-hunks"}
        use {"akinsho/nvim-bufferline.lua"}
        use {"907th/vim-auto-save"}
        use {"nvim-treesitter/nvim-treesitter"}
        use {"ayu-theme/ayu-vim"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"lukas-reineke/indent-blankline.nvim"}
        use { 'Yggdroot/indentLine'}
        use {"APZelos/blamer.nvim"}
        use {"sbdchd/neoformat"}
        use {"neovim/nvim-lspconfig"}
        use {"hrsh7th/nvim-compe"}
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}
        use {"tweekmonster/startuptime.vim"}
        use {"onsails/lspkind-nvim"}
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {"nvim-lua/popup.nvim"}
        use {"voldikss/vim-floaterm"}
        use {"tpope/vim-commentary"}
        use {"chaoren/vim-wordmotion"}
        use {"Konfekt/vim-scratchpad"}
        use {"ntpeters/vim-better-whitespace"}
    end
)
