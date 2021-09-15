local dap = require('dap')

dap.adapters.neovim = function(callback)
  local server = require('lua_debugger').launch()
  callback({ type = 'server'; host = server.host; port = server.port; })
end

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

vim.g.dap_virtual_text = true
