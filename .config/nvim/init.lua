----------------------
-- impatient comes first for load time optimisation
----------------------
require "plugins/configs/impatient"
----------------------------------
-- configurations for most plugins
----------------------------------
require "plugins"
require "plugins/configs/alpha"
require "plugins/configs/autopairs"
require "plugins/configs/autotag"
require "plugins/configs/cmp"
require "plugins/configs/comment"
require "plugins/configs/dressing"
require "plugins/configs/fidget"
require "plugins/configs/gitsigns"
require "plugins/configs/hlargs"
require "plugins/configs/illuminate"
require "plugins/configs/indentline"
require "plugins/configs/lualine"
require "plugins/configs/neoscroll"
require "plugins/configs/null-ls"
require "plugins/configs/nvim-highlight-colors"
require "plugins/configs/nvim-numbertoggle"
require "plugins/configs/nvim-tree"
require "plugins/configs/nvim-treesitter"
require "plugins/configs/package-info"
require "plugins/configs/prettier"
require "plugins/configs/project"
require "plugins/configs/specs"
require "plugins/configs/spectre"
require "plugins/configs/surround"
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

----------------------
-- all settings
----------------------
require "settings/keymaps"
require "settings/options"
require "settings/styles"
