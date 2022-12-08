local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

if not lspconfig_status_ok then
	return
end

local mason_lspconfig_status_ok, masonLspconfig = pcall(require, "mason-lspconfig")

if not mason_lspconfig_status_ok then
	return
end

masonLspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		"bashls",
		"cssls",
		"dockerls",
		-- "eslint_d",
		"html",
		"luau_lsp",
		-- "prettierd",
		-- "stylua",
		"sumneko_lua",
		"tailwindcss",
		"terraformls",
		"tsserver",
		"vuels",
		"yamlls",
	},
})

masonLspconfig.setup_handlers({
	-- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
	function(server_name)
		lspconfig[server_name].setup({})
	end,
	-- You can also override the default handler for specific servers by providing them as keys, like so:
	["rust_analyzer"] = function()
		require("rust-tools").setup({})
	end,
})
