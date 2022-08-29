----------------------
-- all settings
----------------------
require "settings/keymaps"
require "settings/options"
require "settings/styles"
----------------------------------
-- all configurations for plugins
----------------------------------
require "plugins"
require "plugins/configs/autocommands"
require "plugins/configs/autopairs"
require "plugins/configs/autotag"
require "plugins/configs/cmp"
require "plugins/configs/comment"
require "plugins/configs/dap"
require "plugins/configs/gitsigns"
require "plugins/configs/illuminate"
require "plugins/configs/indentline"
require "plugins/configs/lualine"
require "plugins/configs/lsp-colors"
require "plugins/configs/lspsaga"
require "plugins/configs/neoscroll"
require "plugins/configs/nvim-tree"
require "plugins/configs/nvim-treesitter"
require "plugins/configs/null-ls"
require "plugins/configs/poimandres"
require "plugins/configs/prettier"
require "plugins/configs/specs"
require "plugins/configs/spectre"
require "plugins/configs/telescope"
require "plugins/configs/toggleterm"
require "plugins/configs/trouble"
require "plugins/configs/whichkey"
-------------------------------------------
-- mason --> mason-lspconfig --> lspconfig 
-- must be setup in this order
-------------------------------------------
require "plugins/configs/mason"
require "plugins/configs/mason-lspconfig"
require "plugins/configs/lspconfig"
