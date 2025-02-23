return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          [[             ]],
          [[   █  █   ]],
          [[   █ ██   ]],
          [[   ████   ]],
          [[   ██ ███   ]],
          [[   █  █   ]],
          [[             ]],
          [[ n e o v i m ]],
        }, "\n"),
      },
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = "colorscript -e square",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              title = "Browse Repo",
              cmd = "",
              action = function()
                Snacks.gitbrowse()
              end,
              key = "b",
              icon = " ",
              height = 1,
            },
            {
              title = "Notifications",
              cmd = "gh notify -s -a -n5",
              action = function()
                vim.ui.open("https://github.com/notifications")
              end,
              key = "N",
              icon = " ",
              height = 5,
              enabled = true,
            },
            -- {
            --   title = "Open Issues",
            --   cmd = "gh issue list -L 3",
            --   key = "i",
            --   action = function()
            --     vim.fn.jobstart("gh issue list --web", { detach = true })
            --   end,
            --   icon = " ",
            --   height = 5,
            -- },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3",
              key = "P",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
              height = 7,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
      },
    },
    -- debug = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    indent = {
      enabled = true,
      scope = { enabled = false },
      -- indent = {
      --   char = "│",
      -- },
    },
    image = { enabled = true },
    -- input = { enabled = true },
    lazygit = { enabled = false, configure = false },
    notifier = {
      enabled = true,
      timeout = 3000,
      top_down = false,
    },
    picker = {
      enabled = true,
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = false, -- frecency bonus
      },
      icons = {
        diagnostics = {
          Error = "󰅚 ",
          Warn = "󰀪 ",
          Hint = "󰌶 ",
          Info = " ",
        },
      },
      sources = {
        files = { hidden = true },
        buffers = { hidden = true, layout = { preset = "vscode" } },
        grep = { hidden = true },
        explorer = {
          enabled = true,
          hidden = true,
          auto_close = false,
          win = {
            list = {
              keys = {
                ["-"] = "edit_split",
                ["|"] = "edit_vsplit",
                ["<CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                ["O"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                ["o"] = "confirm",
                ["<BS>"] = "explorer_up",
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["p"] = "explorer_paste",
                ["u"] = "explorer_update",
                ["<C-t>"] = "terminal",
                ["x"] = "explorer_move",
                ["y"] = "explorer_yank",
                ["<c-c>"] = "explorer_cd",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
              },
            },
          },
        },
      },
    },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    -- styles = {
    --   notification = {
    --     -- wo = { wrap = true } -- Wrap notifications
    --   },
    -- },
    terminal = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
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
      desc = "search open buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "visual selection or word",
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
      desc = "search registers",
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
      desc = "search commands",
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
      desc = "search highlights",
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
      desc = "search location list",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "search man pages",
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
      desc = "search resume",
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
      desc = "toggle zen mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "toggle zoom",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "toggle scratch buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "select scratch buffer",
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
      "<leader>ft",
      function()
        Snacks.picker.explorer()
      end,
      desc = "filetree explorer",
      mode = { "n" },
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "notifications dismissal",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "next reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "prev reference",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "neovim news",
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
    {
      "`",
      function()
        Snacks.terminal.toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle Terminal",
    },
    { "<c-h>", [[<C-\><C-n><C-W>h]], mode = "t", desc = "window movement: move left" },
    { "<c-j>", [[<C-\><C-n><C-W>j]], mode = "t", desc = "window movement: move down" },
    { "<c-k>", [[<C-\><C-n><C-W>k]], mode = "t", desc = "window movement: move up" },
    { "<c-l>", [[<C-\><C-n><C-W>l]], mode = "t", desc = "window movement: move right" },
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
        Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us", { desc = "toggle spelling" })
        Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw", { desc = "toggle word wrap" })
        Snacks.toggle
          .option("relativenumber", { name = "relative number" })
          :map("<leader>urn", { desc = "toggle relative number" })
        Snacks.toggle.diagnostics():map("<leader>ud", { desc = "toggle diagnostics" })
        Snacks.toggle.line_number():map("<leader>ul", { desc = "toggle line numbers" })
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc", { desc = "toggle conceallevel" })
        Snacks.toggle.treesitter():map("<leader>uT", { desc = "toggle treesitter highlights" })
        Snacks.toggle.inlay_hints():map("<leader>uh", { desc = "toggle inlay hints" })
        Snacks.toggle.indent():map("<leader>ug", { desc = "toggle indent guides" })
        Snacks.toggle.dim():map("<leader>uD", { desc = "toggle dimming" })
      end,
    })
  end,
}
