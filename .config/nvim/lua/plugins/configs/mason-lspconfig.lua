local present, masonLspconfig = pcall(require, "mason-lspconfig")

if not present then
  return
end

masonLspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
     "bash-language-server",
     "css-lsp",
     "eslint_d",
     "dockerfile-language-server",
     "html-lsp",
     "lua-language-server",
     "prettierd",
     "stylua",
     "sumneko_lua",
     "tailwindcss-language-server",
     "terraform-ls",
     "typescript-language-server",
     "vue-language-server",
     "yaml-language-server",
}
})
