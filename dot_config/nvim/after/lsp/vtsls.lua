---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath("data")
              .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifier = "relative",
      },
    },
    javascript = {
      preferences = {
        importModuleSpecifier = "relative",
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   if vim.bo[bufnr].filetype == "vue" then
  --     client.server_capabilities.semanticTokensProvider = nil
  --   end
  -- end,
}
