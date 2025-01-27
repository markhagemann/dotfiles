return {
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")

      require("statuscol").setup({
        relculright = true,
        bt_ignore = { "nofile", "prompt", "terminal" },
        ft_ignore = {
          "NvimTree",
          "dashboard",
          "nvcheatsheet",
          "dapui_watches",
          "dbui",
          "dap-repl",
          "dapui_console",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "help",
          "vim",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "noice",
          "lazy",
          "nvdash",
          "toggleterm",
        },
        segments = {
          -- Segment : Show signs with one character width
          {
            sign = {
              name = { ".*" },
              -- name = {
              --   "Dap",
              --   "neotest",
              --   "Diagnostic",
              -- },
              maxwidth = 1,
              colwidth = 1,
            },
            auto = true,
            click = "v:lua.ScSa",
          },
          -- Segment: Add padding
          {
            text = { " " },
          },
          -- Segment: Show line number
          {
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
            condition = { true, builtin.not_empty },
          },
          -- Segment: GitSigns exclusive
          {
            sign = {
              namespace = { "gitsign.*" },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          -- Segment: Fold Column
          {
            text = { builtin.foldfunc },
            click = "v:lua.ScFa",
            maxwidth = 1,
            colwidth = 1,
            auto = false,
          },
          -- Segment: Add padding
          {
            text = { " " },
            hl = "Normal",
            condition = { true, builtin.not_empty },
          },
        },
      })
    end,
  },
}
