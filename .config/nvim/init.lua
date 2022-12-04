----------------------------------
-- all utility functions
----------------------------------
require("util")

----------------------------------
-- all configurations for plugins
----------------------------------
require("config.plugins-setup")
require("config.plugins.autopairs")
require("config.plugins.comment")
require("config.plugins.dap")
require("config.plugins.gitsigns")
require("config.plugins.impatient")
require("config.plugins.lualine")
require("config.plugins.lsp.formatting")
require("config.plugins.lsp.mason")
require("config.plugins.lsp.lspsaga")
require("config.plugins.lsp.lspconfig")
require("config.plugins.lsp.null-ls")
require("config.plugins.nvim-cmp")
require("config.plugins.nvim-tree")
require("config.plugins.telescope")
require("config.plugins.tokyonight")
require("config.plugins.treesitter")
require("config.plugins.trouble")

----------------------
-- all settings
----------------------
require("config.core.autocommands")
require("config.core.options")
require("config.core.keymaps")
require("config.core.colorscheme")
