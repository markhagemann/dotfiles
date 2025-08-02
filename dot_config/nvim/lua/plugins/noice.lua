return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      hover = {
        silent = true,
      },
      signature = {
        enabled = false,
      },
    },
    notify = {
      enabled = false,
    },
    presets = {
      lsp_doc_border = true, -- adds a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
}
