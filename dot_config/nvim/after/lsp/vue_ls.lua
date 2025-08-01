---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
      if #clients == 0 then
        vim.notify("Could not find `vtsls` lsp client, vue_lsp will not work without it!", vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = "typescript.tsserverRequest",
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        -- TODO: handle error or response nil here, e.g. logging
        -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
        local response_data = { { id, response } }

        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify("tsserver/response", response_data)
      end)
    end
  end,
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        parameterTypes = {
          enabled = true,
          suppressWhenArgumentMatchesName = true,
        },
        variableTypes = {
          enabled = true,
        },
      },
    },
  },
}
