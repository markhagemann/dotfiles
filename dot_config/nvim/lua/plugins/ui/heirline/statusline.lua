-- Taken from https://github.com/olimorris/dotfiles
local utils = require("heirline.utils")
local conditions = require("heirline.conditions")
local colors = require("utils.colors").theme -- Load theme colors
local icons = require("utils.icons") -- Load theme colors
local vi_mode_colors = require("utils.colors").vi_mode_colors -- Load vi_mode colors

local LeftSlantStart = {
  provider = "",
  hl = { fg = colors.background, bg = colors.bblack }, -- "bg" here refers to the theme background
}
local LeftSlantEnd = {
  provider = "",
  hl = { fg = colors.bblack, bg = colors.background }, -- "bg" here refers to the theme background
}
local RightSlantStart = {
  provider = "",
  hl = { fg = colors.bblack, bg = colors.background }, -- "bg" here refers to the theme background
}
local RightSlantEnd = {
  provider = "",
  hl = { fg = colors.background, bg = colors.bblack }, -- "bg" here refers to the theme background
}

local VimMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
  static = {
    mode_names = {
      n = "NORMAL",
      no = "NORMAL",
      nov = "NORMAL",
      noV = "NORMAL",
      ["no\22"] = "NORMAL",
      niI = "NORMAL",
      niR = "NORMAL",
      niV = "NORMAL",
      nt = "NORMAL",
      v = "VISUAL",
      vs = "VISUAL",
      V = "VISUAL",
      Vs = "VISUAL",
      ["\22"] = "VISUAL",
      ["\22s"] = "VISUAL",
      s = "SELECT",
      S = "SELECT",
      ["\19"] = "SELECT",
      i = "INSERT",
      ic = "INSERT",
      ix = "INSERT",
      R = "REPLACE",
      Rc = "REPLACE",
      Rx = "REPLACE",
      Rv = "REPLACE",
      Rvc = "REPLACE",
      Rvx = "REPLACE",
      c = "COMMAND",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "TERM",
    },
    mode_colors = {
      n = vi_mode_colors.normal,
      i = vi_mode_colors.insert,
      v = vi_mode_colors.visual,
      V = vi_mode_colors.visual,
      ["\22"] = vi_mode_colors.visual,
      c = vi_mode_colors.command,
      s = vi_mode_colors.visual,
      S = vi_mode_colors.visual,
      ["\19"] = vi_mode_colors.visual,
      r = vi_mode_colors.insert,
      R = vi_mode_colors.insert,
      ["!"] = vi_mode_colors.terminal,
      t = vi_mode_colors.terminal,
    },
  },
  {
    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      return { fg = colors.background, bg = self.mode_color, bold = true }
    end,
  },
  {
    provider = "",
    hl = function(self)
      return { fg = self.mode_color, bg = colors.background }
    end,
  },
}

local GitBranch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
  {
    condition = function(self)
      return not conditions.buffer_matches({
        filetype = self.filetypes,
      })
    end,
    LeftSlantStart,
    {
      provider = function(self)
        return "  " .. (self.status_dict.head == "" and "main" or self.status_dict.head) .. " "
      end,
      hl = { fg = colors.black, bg = colors.bblack },
    },
    {
      condition = function()
        return (_G.GitStatus ~= nil and (_G.GitStatus.ahead ~= 0 or _G.GitStatus.behind ~= 0))
      end,
      update = {
        "User",
        pattern = "GitStatusChanged",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },
      {
        condition = function()
          return _G.GitStatus.status == "pending"
        end,
        provider = " ",
        hl = { fg = colors.black, bg = colors.bblack },
      },
      {
        provider = function()
          return _G.GitStatus.behind .. " "
        end,
        hl = function()
          return { fg = _G.GitStatus.behind == 0 and colors.black or colors.red, bg = colors.bblack }
        end,
      },
      {
        provider = function()
          return _G.GitStatus.ahead .. " "
        end,
        hl = function()
          return { fg = _G.GitStatus.ahead == 0 and colors.black or colors.green, bg = colors.bblack }
        end,
      },
    },
    LeftSlantEnd,
  },
}

local FileBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then
      return "[No Name]"
    end
    return " " .. filename .. " "
  end,
  hl = { fg = colors.black, bg = colors.bblack },
}

local FileFlags = {
  -- {
  --   condition = function() return vim.bo.modified end,
  --   provider = " ",
  --   hl = { fg = colors.black },
  -- },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = " ",
    hl = { fg = colors.black },
  },
}

local FileNameBlock = utils.insert(FileBlock, LeftSlantStart, utils.insert(FileName, FileFlags), LeftSlantEnd)

---Return the LspDiagnostics from the LSP servers
local LspDiagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  -- Errors
  {
    condition = function(self)
      return self.errors > 0
    end,
    hl = { fg = colors.background, bg = colors.bblack },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return " " .. icons.diagnostics.error .. self.errors .. " "
        end,
        hl = { bg = colors.bblack, fg = colors.red },
      },
      {
        provider = "",
        hl = { bg = colors.background, fg = colors.bblack },
      },
    },
  },
  -- Warnings
  {
    condition = function(self)
      return self.warnings > 0
    end,
    hl = { fg = colors.background, bg = colors.bblack },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return " " .. icons.diagnostics.warn .. self.warnings .. " "
        end,
        hl = { bg = colors.bblack, fg = colors.yellow },
      },
      {
        provider = "",
        hl = { bg = colors.background, fg = colors.bblack },
      },
    },
  },
  -- Hints
  {
    condition = function(self)
      return self.hints > 0
    end,
    hl = { fg = colors.background, bg = colors.bblack },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return " " .. icons.diagnostics.hint .. self.hints .. " "
        end,
        hl = { bg = colors.bblack, fg = colors.green },
      },
      {
        provider = "",
        hl = { bg = colors.background, fg = colors.bblack },
      },
    },
  },
  -- Info
  {
    condition = function(self)
      return self.info > 0
    end,
    hl = { fg = colors.background, bg = colors.bblack },
    {
      {
        provider = function(self)
          return " " .. icons.diagnostics.info .. self.info .. " "
        end,
        hl = { bg = colors.bblack, fg = colors.blue },
      },
      {
        provider = "",
        hl = { bg = colors.background, fg = colors.bblack },
      },
    },
  },
}

local LspAttached = {
  condition = conditions.lsp_attached,
  static = {
    lsp_attached = false,
    show_lsps = {
      copilot = false,
      -- efm = false,
    },
  },
  init = function(self)
    for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      if self.show_lsps[server.name] ~= false then
        self.lsp_attached = true
        return
      end
    end
  end,
  update = { "LspAttach", "LspDetach" },
  {
    condition = function(self)
      return self.lsp_attached
    end,
    LeftSlantStart,
    {
      provider = "   ",
      hl = { fg = colors.black, bg = colors.bblack },
    },
    LeftSlantEnd,
  },
}

---Return the current line number as a % of total lines and the total lines in the file
local Ruler = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  {
    provider = "",
    hl = { fg = colors.black, bg = colors.background },
  },
  {
    -- %L = number of lines in the buffer
    -- %P = percentage through file of displayed window
    provider = " %P% /%2L ",
    hl = { fg = colors.background, bg = colors.black },
  },
}

local MacroRecording = {
  condition = function(self)
    return vim.fn.reg_recording() ~= ""
  end,
  update = {
    "RecordingEnter",
    "RecordingLeave",
  },
  {
    provider = "",
    hl = { fg = colors.blue, bg = colors.background },
  },
  {
    provider = function(self)
      return " " .. vim.fn.reg_recording() .. " "
    end,
    hl = { bg = colors.blue, fg = colors.background },
  },
  {
    provider = "",
    hl = { fg = colors.background, bg = colors.blue },
  },
}

local SearchResults = {
  condition = function(self)
    return vim.v.hlsearch ~= 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  {
    provider = "",
    hl = function()
      -- Assuming 'Substitute' highlight group uses background from colors.yellow as typically search highlights are yellow
      -- If heirline.utils.get_highlight("Substitute") returns actual hex codes, this is fine
      return { fg = utils.get_highlight("Substitute").bg, bg = colors.background }
    end,
  },
  {
    condition = function(self)
      return self.search and self.search.current and self.search.total and self.search.maxcount
    end,
    provider = function(self)
      local search = self.search
      return string.format(" %d/%d ", search.current, math.min(search.total, search.maxcount))
    end,
    hl = function()
      return { bg = utils.get_highlight("Substitute").bg, fg = colors.background }
    end,
  },
  {
    provider = "",
    hl = function()
      return { bg = utils.get_highlight("Substitute").bg, fg = colors.background }
    end,
  },
}

---Return the status of the current session
local Session = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  RightSlantStart,
  {
    provider = function(self)
      if vim.g.persisting then
        return " 󰅠  "
      end
      return " 󰅣  "
    end,
    hl = { fg = colors.black, bg = colors.bblack },
    update = {
      "User",
      pattern = { "PersistedToggle", "PersistedDeletePost" },
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  },
  RightSlantEnd,
}

local CodeCompanion = {
  static = {
    processing = false,
  },
  update = {
    "User",
    pattern = "CodeCompanionRequest*",
    callback = function(self, args)
      if args.match == "CodeCompanionRequestStarted" then
        self.processing = true
      elseif args.match == "CodeCompanionRequestFinished" then
        self.processing = false
      end
      vim.cmd("redrawstatus")
    end,
  },
  {
    condition = function(self)
      return self.processing
    end,
    provider = " ",
    hl = { fg = colors.yellow },
  },
}
local CodeCompanionAgent = {
  static = {
    processing = false,
  },
  update = {
    "User",
    pattern = "CodeCompanionAgent*",
    callback = function(self, args)
      if args.match == "CodeCompanionAgentStarted" then
        self.processing = true
      elseif args.match == "CodeCompanionAgentFinished" then
        self.processing = false
      end
      vim.cmd("redrawstatus")
    end,
  },
  {
    condition = function(self)
      return self.processing
    end,
    provider = "󱙺 ",
    hl = { fg = colors.green },
  },
}

local function OverseerTasksForStatus(status)
  return {
    condition = function(self)
      return self.tasks[status]
    end,
    provider = function(self)
      return string.format("%s%d", self.symbols[status], #self.tasks[status])
    end,
    hl = function(self)
      return {
        fg = self.colors[status],
      }
    end,
  }
end

local Overseer = {
  condition = function()
    return package.loaded.overseer
  end,
  init = function(self)
    local tasks = require("overseer.task_list").list_tasks({ unique = true })
    local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
    self.tasks = tasks_by_status
  end,
  static = {
    symbols = {
      ["CANCELED"] = "  ",
      ["FAILURE"] = "  ",
      ["RUNNING"] = " 省",
      ["SUCCESS"] = "  ",
    },
    colors = {
      ["CANCELED"] = colors.black,
      ["FAILURE"] = colors.red,
      ["RUNNING"] = colors.yellow,
      ["SUCCESS"] = colors.green,
    },
  },
  OverseerTasksForStatus("CANCELED"),
  OverseerTasksForStatus("RUNNING"),
  OverseerTasksForStatus("SUCCESS"),
  OverseerTasksForStatus("FAILURE"),
}

local Dap = {
  condition = function()
    local session = require("dap").session()
    return session ~= nil
  end,
  provider = function()
    return "  "
  end,
  hl = { fg = colors.red },
}

-- Show plugin updates available from lazy.nvim
local Lazy = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    }) and require("lazy.status").has_updates()
  end,
  update = {
    "User",
    pattern = "LazyCheck",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
  provider = function()
    return " 󰚰 " .. require("lazy.status").updates() .. " "
  end,
  hl = { fg = colors.black },
}

--- Return information on the current buffers filetype
local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. " ")
  end,
  hl = { fg = colors.black, bg = colors.bblack },
}

local FileType = {
  provider = function()
    return string.lower(vim.bo.filetype) .. " "
  end,
  hl = { fg = colors.black, bg = colors.bblack },
}

local FileType = utils.insert(FileBlock, RightSlantStart, FileIcon, FileType, RightSlantEnd)

--- Return information on the current file's encoding
local FileEncoding = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  RightSlantStart,
  {
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return " " .. enc .. " "
    end,
    hl = {
      fg = colors.black,
      bg = colors.bblack,
    },
  },
  RightSlantEnd,
}

return {
  static = {
    filetypes = {
      "^git.*",
      "fugitive",
      "alpha",
      "^neo--tree$",
      "^neotest--summary$",
      "^neo--tree--popup$",
      "^NvimTree$",
      "snacks_dashboard",
      "^toggleterm$",
    },
    force_inactive_filetypes = {
      "^aerial$",
      "^alpha$",
      "^chatgpt$",
      "^frecency$",
      "^lazy$",
      "^lazyterm$",
      "^netrw$",
      "^TelescopePrompt$",
      "^undotree$",
    },
  },
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.force_inactive_filetypes,
    })
  end,
  {
    VimMode,
    GitBranch,
    -- FileNameBlock,
    LspAttached,
    LspDiagnostics,
    { provider = "%=", hl = { bg = colors.background } },
    CodeCompanionAgent,
    CodeCompanion,
    Overseer,
    Dap,
    Lazy,
    FileType,
    -- FileEncoding,
    Session,
    MacroRecording,
    SearchResults,
    Ruler,
  },
}
