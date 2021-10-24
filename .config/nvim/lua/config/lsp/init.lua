local util = require("util")
local lspconfig = require("lspconfig")

if vim.lsp.setup then
	vim.lsp.setup({
		floating_preview = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
		diagnostics = {
			signs = { error = " ", warning = " ", hint = " ", information = " " },
			display = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
		},
		completion = {
			kind = {
				Class = " ",
				Color = " ",
				Constant = " ",
				Constructor = " ",
				Enum = "了 ",
				EnumMember = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = " ",
				Interface = "ﰮ ",
				Keyword = " ",
				Method = "ƒ ",
				Module = " ",
				Property = " ",
				Snippet = "﬌ ",
				Struct = " ",
				Text = " ",
				Unit = " ",
				Value = " ",
				Variable = " ",
			},
		},
	})
else
	-- require("config.lsp.saga")
	require("config.lsp.diagnostics")
	require("config.lsp.kind").setup()
end

local function on_attach(client, bufnr)
	require("config.lsp.formatting").setup(client, bufnr)
	require("config.lsp.keys").setup(client, bufnr)
	require("config.lsp.completion").setup(client, bufnr)
	require("config.lsp.highlighting").setup(client)

	-- TypeScript specific stuff
	if client.name == "typescript" or client.name == "tsserver" then
		require("config.lsp.ts-utils").setup(client)
	end
end

USER = vim.fn.expand("$USER")
local sumneko_root_path = "/home/" .. USER .. "/packages/lua-language-server"
local sumneko_binary = "/home/" .. USER .. "/packages/lua-language-server/bin/Linux/lua-language-server"

local servers = {
	-- pyright = {},
	bashls = {},
	dockerls = {},
	tsserver = {},
	cssls = { cmd = { "css-languageserver", "--stdio" } },
	-- rnix = {},
	jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
	html = { cmd = { "html-languageserver", "--stdio" } },
	-- clangd = {},
	-- gopls = {},
	-- intelephense = {},
	efm = require("config.lsp.efm").config,
	sumneko_lua = {
		cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		},
	},
	vimls = {},
	-- tailwindcss = {},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require("workspace").setup()
require("lua-dev").setup()

for server, config in pairs(servers) do
	lspconfig[server].setup(vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}, config))
	local cfg = lspconfig[server]
	if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
		util.error(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
	end
end
