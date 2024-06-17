local opts = {
  filters = {
    auto_imports = true,
    auto_components = true,
    import_same_file = true,
    declaration = true,
    duplicate_filename = true,
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  detection = {
    -- nuxt = function()
    --   return vim.fn.glob(".nuxt/") ~= ""
    -- end,
    vue3 = function()
      return vim.fn.filereadable("vite.config.ts") == 1 or vim.fn.filereadable("quasar.conf.js") == 1
    end,
    priority = { "vue3" },
  },
  lsp = {
    override_definition = true, -- override vim.lsp.buf.definition
  },
  debounce = 200,
}

return {
  "catgoose/vue-goto-definition.nvim",
  event = "BufReadPre",
  opts = opts,
}
