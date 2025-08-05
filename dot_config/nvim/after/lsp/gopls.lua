---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
