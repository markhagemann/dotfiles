return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    notify = {
      enabled = false,
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
}
