----------------------
-- impatient comes first for load time optimisation
----------------------
require "plugins/configs/impatient"
----------------------
-- all settings
----------------------
require "settings/autocommands"
require "settings/keymaps"
require "settings/options"
require "settings/styles"
----------------------------------
-- configurations for most plugins
----------------------------------
require "plugins"
require "plugins/configs/alpha"
require "plugins/configs/autopairs"
require "plugins/configs/autotag"
require "plugins/configs/cmp"
require "plugins/configs/comment"
require "plugins/configs/gitsigns"
require "plugins/configs/illuminate"
require "plugins/configs/indentline"
require "plugins/configs/lualine"
require "plugins/configs/neoscroll"
require "plugins/configs/null-ls"
require "plugins/configs/nvim-tree"
require "plugins/configs/nvim-treesitter"
require "plugins/configs/prettier"
require "plugins/configs/project"
require "plugins/configs/specs"
require "plugins/configs/spectre"
require "plugins/configs/telescope"
require "plugins/configs/toggleterm"
require "plugins/configs/tokyonight"
require "plugins/configs/trouble"
require "plugins/configs/whichkey"
----------------------------------
-- keep these last
----------------------------------
require "plugins/configs/lsp"
require "plugins/configs/dap"
