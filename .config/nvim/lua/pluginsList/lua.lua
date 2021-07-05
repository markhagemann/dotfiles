-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        -------------------
        -- Package manager
        -------------------
        use {"wbthomason/packer.nvim", opt = true}

        -------------------
        -- Commonly depended on
        -------------------

        -- Icon support
        use {"kyazdani42/nvim-web-devicons"}
        -- Popup
        use {"nvim-lua/popup.nvim"}
        -- Utility
        use {"nvim-lua/plenary.nvim"}

        -------------------
        -- General
        -------------------

        -- Colorscheme
        use {"folke/tokyonight.nvim"}
        use {"kuntau/ayu-vim"}
        use {"norcalli/nvim-colorizer.lua"}
        -- Debugging
        use {"mfussenegger/nvim-lua-debugger"}
        use {"mfussenegger/nvim-dap"}
        use {"theHamsta/nvim-dap-virtual-text"}
        -- File manager
        use {
          "ahmedkhalf/lsp-rooter.nvim",
          config = function()
            require("lsp-rooter").setup {
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
            }
          end
        }
        use {"airblade/vim-rooter"}
        use {"kyazdani42/nvim-tree.lua"}
        -- Fuzzy finder
        use {"famiu/bufdelete.nvim"}
        use {
          'nvim-telescope/telescope.nvim',
          requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {"nvim-telescope/telescope-media-files.nvim"}
        -- Git
        use {"APZelos/blamer.nvim"}
        use {"airblade/vim-gitgutter"}
        use {"sindrets/diffview.nvim"}
        -- Icon support
        -- use {
        --   'yamatsum/nvim-web-nonicons',
        --   requires = {'kyazdani42/nvim-web-devicons'}
        -- }
        -- Line indent
        use {"lukas-reineke/indent-blankline.nvim"}
        -- LSP
        use {"tpope/vim-sleuth"}
        use {"sbdchd/neoformat"}
        use {"neovim/nvim-lspconfig"}
        use {"glepnir/lspsaga.nvim"}
        use {"hrsh7th/nvim-compe", branch = 'master'}
        use {"folke/lsp-colors.nvim"}
        use {
          "folke/trouble.nvim",
          requires = "kyazdani42/nvim-web-devicons",
          config = function()
            require("trouble").setup {
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
            }
          end
        }
        -- use {"alvan/vim-closetag"}
        use {"onsails/lspkind-nvim"}
        use {"nvim-treesitter/nvim-treesitter"}
        use {"windwp/nvim-ts-autotag"}
        use {"windwp/nvim-autopairs"}
        use {"elzr/vim-json"}
        use {"plasticboy/vim-markdown"}
        use {"joukevandermaas/vim-ember-hbs"}
        use {"leafgarland/typescript-vim"}
        use {"peitalin/vim-jsx-typescript"}
        use {"folke/lua-dev.nvim"}
        -- use {"andymass/vim-matchup"}
        -- Scratchpad
        use {"Konfekt/vim-scratchpad"}
        -- Statusline
        use {"glepnir/galaxyline.nvim"}
        -- Todo Tracker
        use {
          "folke/todo-comments.nvim",
          requires = "nvim-lua/plenary.nvim",
          config = function()
            require("todo-comments").setup {
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
            }
          end
        }
        -- Utility
        use {"tweekmonster/startuptime.vim"}
        use {"tpope/vim-abolish"}
        -- Whitespace trim
        use {"ntpeters/vim-better-whitespace"}
        -- Word manipulation
        use {"terrortylor/nvim-comment"}
        use {"chaoren/vim-wordmotion"}
    end
)
