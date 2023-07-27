return {
  { "APZelos/blamer.nvim" },
  { "arthurxavierx/vim-caser" },
  { "christoomey/vim-tmux-navigator" },
  { "chaoren/vim-wordmotion" },
  { "echasnovski/mini.surround", version = "*" },
  { "/folke/lsp-colors.nvim" },
  { "kburdett/vim-nuuid" },
  {
    "lewis6991/spaceless.nvim",
    config = function()
      require("spaceless").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_leader = ";"
    end,
  },
  { "sitiom/nvim-numbertoggle" },
  {
    "tomiis4/Hypersonic.nvim",
    event = "CmdlineEnter",
    cmd = "Hypersonic",
    config = function()
      require("hypersonic").setup({
        -- config
      })
    end,
  },
  { "tpope/vim-sleuth" },
}
