--- Discover directories under root that contain a Go main package (package main).
---@param root string directory path to search
---@return string[] list of directory paths (unique)
local function find_go_main_dirs(root)
  root = vim.fn.fnamemodify(root, ":p")
  if vim.fn.isdirectory(root) ~= 1 then
    return {}
  end
  local dirs = {}
  local seen = {}
  local go_files = vim.fn.glob(root .. "/**/*.go", true, true) or {}
  for _, f in ipairs(go_files) do
    local dir = vim.fn.fnamemodify(f, ":h")
    if seen[dir] then
      goto continue
    end
    local ok, first_decl = pcall(function()
      local fp = io.open(f, "r")
      if not fp then return nil end
      for _ = 1, 20 do
        local line = fp:read("*l")
        if not line then fp:close(); return nil end
        line = line:match("^%s*(.-)%s*$")
        if line ~= "" and not line:match("^//") and not line:match("^%*") then
          fp:close()
          return line
        end
      end
      fp:close()
      return nil
    end)
    if ok and first_decl and first_decl:match("^package%s+main%s*$") then
      seen[dir] = true
      dirs[#dirs + 1] = dir
    end
    ::continue::
  end
  table.sort(dirs, function(a, b)
    local a_cmd = a:find("/cmd/") and 1 or 0
    local b_cmd = b:find("/cmd/") and 1 or 0
    if a_cmd ~= b_cmd then return a_cmd > b_cmd end
    return a < b
  end)
  return dirs
end

--- If program is workspace root with no Go main, set program to a discovered main package dir.
---@param config dap.Configuration
---@return dap.Configuration
local function ensure_go_program_in_workspace(config)
  local t = config.type
  if t ~= "go" and t ~= "delve" then
    return config
  end
  if config.request == "attach" or config.mode == "test" then
    return config
  end
  local program = config.program
  if type(program) ~= "string" then
    return config
  end
  program = program:gsub("%${workspaceFolder}", vim.fn.getcwd())
  program = vim.fn.fnamemodify(program, ":p")
  if vim.fn.isdirectory(program) ~= 1 then
    return config
  end
  local main_dirs = find_go_main_dirs(program)
  if #main_dirs == 0 then
    return config
  end
  local root_has_main = false
  for _, d in ipairs(main_dirs) do
    if d == program then
      root_has_main = true
      break
    end
  end
  if root_has_main then
    return config
  end
  config = vim.deepcopy(config)
  config.program = main_dirs[1]
  return config
end

---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

return {
  {
    -- Debug Adapter Protocol (DAP) for debugging support in Neovim
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      -- User interface for DAP debugging (already described above)
      "rcarriga/nvim-dap-ui",
      -- Virtual text for the debugger showing variable values inline
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          virt_text_win_col = 80,
        },
      },
      -- Language-specific debuggers
      -- Go debugger adapter for DAP
      "leoluz/nvim-dap-go",
    },

    -- stylua: ignore
    keys = {
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with args" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('breakpoint condition: ')) end, desc = "Breakpoint condition" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/continue" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle repl" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle dapui" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      -- Set DAP log level to TRACE and open log files (do this *before* starting a debug session to capture trace)
      { "<leader>dL", function()
        require("dap").set_log_level("TRACE")
        require("dap._cmds").show_logs()
        vim.notify("DAP log level set to TRACE; logs opened. Start debugging to capture trace.", vim.log.levels.INFO, { title = "DAP" })
      end, desc = "DAP: set TRACE and show logs" },
    },

    config = function()
      -- Resolve delve path once; Mason's bin often isn't in PATH when Neovim starts.
      local mason_delve = vim.fn.stdpath("data") .. "/mason/bin/dlv"
      local delve_path = (vim.fn.executable(mason_delve) == 1) and mason_delve
        or (vim.fn.exepath("dlv") ~= "" and vim.fn.exepath("dlv") or "dlv")

      -- load mason-nvim-dap here, after all adapters have been setup
      local mason_nvim_dap = require("lazy.core.config").spec.plugins["mason-nvim-dap.nvim"]
      local Plugin = require("lazy.core.plugin")
      local mason_nvim_dap_opts = Plugin.values(mason_nvim_dap, "opts", false)
      mason_nvim_dap_opts.handlers = mason_nvim_dap_opts.handlers or {}
      mason_nvim_dap_opts.handlers.delve = function(config)
        if config.adapters and config.adapters.executable then
          config.adapters.executable.command = delve_path
        end
        -- Delve can be slow to build/start on large Go projects; default 4s is too short
        config.adapters.options = vim.tbl_extend("force", config.adapters.options or {}, {
          initialize_timeout_sec = 30,
        })
        require("mason-nvim-dap").default_setup(config)
      end
      require("mason-nvim-dap").setup(mason_nvim_dap_opts)

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local dap_icons = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = ".>",
      }
      for name, sign in pairs(dap_icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          text = sign[1],
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      -- Map VS Code launch.json type names to nvim-dap filetype configurations
      require("dap.ext.vscode").type_to_filetypes = { go = { "go" } }

      require("dap-go").setup({
        delve = {
          path = delve_path,
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          -- detached = vim.fn.has 'win32' == 0,
        },
      })

      -- Override the go adapter to support remote attach (connect to existing Delve server)
      local original_adapter = require("dap").adapters.go
      require("dap").adapters.go = function(callback, client_config)
        if client_config.mode == "remote" then
          callback({
            type = "server",
            host = client_config.host or "127.0.0.1",
            port = client_config.port,
          })
        else
          original_adapter(callback, client_config)
        end
      end

      -- When program is workspace root with no Go files, discover main packages in subdirs (so launch.json or default config works from any folder).
      require("dap").listeners.on_config["go_discover_main"] = ensure_go_program_in_workspace

      require("overseer").enable_dap()
    end,
  },

  -- fancy UI for the debugger
  {
    -- User interface for DAP debugging with visual breakpoints and variable inspection
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "(debug): toggle" },
      { "<leader>de", function() require("dapui").eval() end, desc = "(debug): eval", mode = {"n", "v"} },
    },
    opts = {
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
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

  -- mason.nvim integration
  {
    -- Mason integration for automatically installing DAP debug adapters
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
        -- Update this to ensure that you have the debuggers for the langs you want
        "chrome-debug-adapter",
        "delve",
        "firefox-debug-adapter",
        "go-debug-adapter",
        "js-debug-adapter",
        "node-debug2-adapter",
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
