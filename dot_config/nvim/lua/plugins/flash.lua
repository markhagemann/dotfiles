return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "zk",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
   --  { "Zk",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
   --  { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote flash" },
   --  { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter search" },
   -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle flash search" },
  },
}
