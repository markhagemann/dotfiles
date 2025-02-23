return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "dap ui" },
        { "<leader>de", function() require("dapui").eval() end,     desc = "eval",  mode = { "n", "v" } },
      },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")

        vim.fn.sign_define("DapBreakpoint", { text = "", numhl = "DapBreakpoint", texthl = "DapBreakpoint" })
        vim.fn.sign_define("DagLogPoint", { text = "", numhl = "DapLogPoint", texthl = "DapLogPoint" })
        vim.fn.sign_define("DapStopped", { text = "", numhl = "DapStopped", texthl = "DapStopped" })
        vim.fn.sign_define(
          "DapBreakpointRejected",
          { text = "", numhl = "DapBreakpointRejected", texthl = "DapBreakpointRejected" }
        )

        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          "js-debug-adapter",
          "node-debug2-adapter",
        },
      },
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "breakpoint condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                                             desc = "continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "run with args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "run to cursor" },
    { "<leader>dg", function() require("dap").goto_() end,                                                desc = "go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end,                                            desc = "step into" },
    { "<leader>dj", function() require("dap").down() end,                                                 desc = "down" },
    { "<leader>dk", function() require("dap").up() end,                                                   desc = "up" },
    { "<leader>dl", function() require("dap").run_last() end,                                             desc = "run last" },
    { "<leader>do", function() require("dap").step_out() end,                                             desc = "step out" },
    { "<leader>dO", function() require("dap").step_over() end,                                            desc = "step over" },
    { "<leader>dp", function() require("dap").pause() end,                                                desc = "pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "toggle repl" },
    { "<leader>ds", function() require("dap").session() end,                                              desc = "session" },
    { "<leader>dt", function() require("dap").terminate() end,                                            desc = "terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "widgets" },
  },

  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  end,
}
