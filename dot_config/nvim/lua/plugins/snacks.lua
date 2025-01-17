return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = true },
    -- debug = { enabled = true },
    dim = { enabled = false },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    indent = { enabled = true, scope = { enabled = false }, char = "│" },
    -- input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      top_down = false,
    },
    picker = {
      enabled = true,
      sources = { files = { hidden = true }, buffers = { hidden = true }, grep = { hidden = true } },
    },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false }, -- need to figure out how fold works with this first
    -- styles = {
    --   notification = {
    --     -- wo = { wrap = true } -- Wrap notifications
    --   },
    -- },
    toggle = { enabled = true },
    -- words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "buffers",
    },
    {
      '<leader>"',
      function()
        Snacks.picker.registers()
      end,
      desc = "registers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "command history",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.files()
      end,
      desc = "files",
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "find buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "find config file",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "find git files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "find recent",
    },
    -- git
    {
      "<leader>gc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "git commit log",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "git status",
    },
    -- grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "search buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "search open Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      "<leader>sf",
      function()
        Snacks.picker.files()
      end,
      desc = "search files",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.registers()
      end,
      desc = "search Registers",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "search autocmds",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "search command history",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "search Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "search diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "search help pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "search Highlights",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "search jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "search keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "search location List",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "search Man Pages",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "search marks",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "search Resume",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "search quickfix list",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.projects()
      end,
      desc = "search projects",
    },
    {
      "<leader>sco",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "search colorschemes",
    },
    -- LSP keymaps within lua/plugins/lsp.lua

    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>ny",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "notification history",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "buffer deletion",
    },
    {
      "<leader>rf",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "rename file",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "git Browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "git blame line",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "lazygit current git file history",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "lazygit log (cwd)",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "notifications dismissal",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ur")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
