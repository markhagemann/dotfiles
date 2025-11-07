local icons = require("utils.icons")

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
      width = 65,
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
        keys = {
          -- { icon = " ", key = "e", desc = "Explore directory", action = "<leader>e" },
          { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
          -- { icon = " ", key = "g", desc = "Find text", action = ":lua snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "r",
            desc = "Recent files",
            action = ":lua Snacks.picker.recent({ filter = { cwd = true } })",
          },
          { icon = " ", key = "s", desc = "Restore session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "󱁤 ", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header", padding = 1 },
        { section = "startup", padding = 1 },
        { section = "keys", gap = 1, padding = 1 },
        function()
          local version = require("utils.info").nvim_version()
          local plugin_stats = require("utils.info").plugin_stats()
          local updates = plugin_stats.updates > 0 and "  " .. plugin_stats.updates .. "" or ""
          return {
            align = "center",
            text = {
              { " ", hl = "footer" },
              { version, hl = "NonText" },
              { "    ", hl = "footer" },
              { tostring(plugin_stats.count), hl = "NonText" },
              { updates, hl = "special" },
              { "   󰛕 ", hl = "footer" },
              { plugin_stats.startuptime .. " ms", hl = "NonText" },
            },
            padding = 1,
          }
        end,
        -- {
        --   pane = 2,
        --   section = "terminal",
        --   cmd = "colorscript -e square",
        --   height = 5,
        --   padding = 1,
        -- },
        -- function()
        --   local is_git = Snacks.git.get_root ~= nil
        --   local is_gitlab_repo = require("utils.info").is_gitlab_repo()
        --   local is_github_repo = require("utils.info").is_github_repo()
        --
        --   local cmds = {
        --     {
        --       title = "Browse Repo",
        --       cmd = "",
        --       action = function()
        --         Snacks.gitbrowse()
        --       end,
        --       key = "b",
        --       icon = " ",
        --       height = 1,
        --       enabled = is_git,
        --     },
        --     {
        --       title = "Notifications",
        --       cmd = "gh notify -s -a -n5",
        --       action = function()
        --         vim.ui.open("https://github.com/notifications")
        --       end,
        --       key = "N",
        --       icon = " ",
        --       height = 2,
        --       width = 65,
        --       enabled = true,
        --     },
        --     {
        --       title = "Pipelines",
        --       cmd = "glab ci list -P 3",
        --       action = function()
        --         -- TODO: This isn't a valid command
        --         vim.fn.jobstart("glab ci list --web", { detach = true })
        --       end,
        --       key = "p",
        --       icon = " ",
        --       height = 5,
        --       width = 65,
        --       enabled = is_gitlab_repo,
        --     },
        --
        --     {
        --       title = "Pipelines",
        --       cmd = "gh run list -L 3",
        --       action = function()
        --         vim.fn.jobstart("gh run list --web", { detach = true })
        --       end,
        --       key = "p",
        --       icon = " ",
        --       height = 5,
        --       width = 65,
        --       enabled = is_github_repo,
        --     },
        --     {
        --       title = "Open Issues",
        --       cmd = "gh issue list -L 3",
        --       key = "i",
        --       action = function()
        --         vim.fn.jobstart("gh issue list --web", { detach = true })
        --       end,
        --       icon = " ",
        --       height = 5,
        --       enabled = is_github_repo,
        --     },
        --     {
        --       icon = " ",
        --       title = "Open MRs",
        --       cmd = "glab mr list -P 5",
        --       key = "m",
        --       action = function()
        --         -- TODO: This isn't a valid command
        --         vim.fn.jobstart("glab mr list --web", { detach = true })
        --       end,
        --       height = 7,
        --       width = 65,
        --       enabled = is_gitlab_repo,
        --     },
        --   }
        -- return vim.tbl_map(function(cmd)
        --   return vim.tbl_extend("force", {
        --     pane = 2,
        --     section = "terminal",
        --     padding = 1,
        --     ttl = 5 * 60,
        --     indent = 3,
        --   }, cmd)
        -- end, cmds)
        -- end,
      },
    },
    -- debug = { enabled = true },
    git = { enabled = false },
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
    lazygit = {
      enabled = true,
      configure = true,
      config = {
        os = {
          editPreset = "nvim-remote",
          edit = '[ -z ""$NVIM"" ] && (nvim -- {{filename}}) || (nvim --server ""$NVIM"" --remote-send ""q"" && nvim --server ""$NVIM"" --remote {{filename}})',
        },
      },
    },
    notifier = {
      enabled = true,
      timeout = 1500,
      top_down = false,
    },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<C-y>"] = { "list_scroll_up_1", mode = { "n" } },
            ["<C-e>"] = { "list_scroll_down_1", mode = { "n" } },
          },
        },
        list = {
          keys = {
            ["<C-y>"] = { "list_scroll_up_1", mode = { "n" } },
            ["<C-e>"] = { "list_scroll_down_1", mode = { "n" } },
          },
        },
      },
      formatters = {
        file = {
          truncate = 60, -- truncate the file path to (roughly) this length
        },
      },
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
          Error = icons.diagnostics.error,
          Warn = icons.diagnostics.warn,
          Hint = icons.diagnostics.hint,
          Info = icons.diagnostics.info,
        },
      },
      sources = {
        files = { hidden = true },
        buffers = {
          hidden = true,
          layout = { preset = "vscode" },
        },
        grep = { hidden = true },
        explorer = {
          enabled = true,
          ignored = true,
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
                ["d"] = "safe_delete",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["p"] = "explorer_paste",
                ["u"] = "explorer_update",
                ["<C-t>"] = "terminal",
                ["x"] = "explorer_move",
                ["y"] = "explorer_yank",
                ["Y"] = "copy_path",
                ["<c-c>"] = "explorer_cd",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
              },
            },
          },
          actions = {
            copy_path = function(_, item)
              local modify = vim.fn.fnamemodify

              local filepath = item.file
              local filename = modify(filepath, ":t")

              local results = {
                filepath,
                modify(filepath, ":."),
                modify(filepath, ":~"),
                filename,
                modify(filename, ":r"),
                modify(filename, ":e"),
              }

              local items = {
                "Absolute path: " .. results[1],
                "Path relative to CWD: " .. results[2],
                "Path relative to HOME: " .. results[3],
                "Filename: " .. results[4],
              }

              if vim.fn.isdirectory(filepath) == 0 then
                vim.list_extend(items, {
                  "Filename without extension: " .. results[5],
                  "Extension of the filename: " .. results[6],
                })
              end

              vim.ui.select(items, { prompt = "Choose to copy to clipboard:" }, function(choice, i)
                if not choice then
                  vim.notify("Selection cancelled")
                  return
                end
                if not i then
                  vim.notify("Invalid selection")
                  return
                end
                local result = results[i]
                vim.fn.setreg("*", result)
                vim.notify("Copied: " .. result)
              end)
            end,
            safe_delete = function(picker)
              local selected = picker:selected({ fallback = true })
              local is_root = vim.iter(selected):any(function(s)
                return not s.parent
              end)
              if is_root then
                vim.print("No, bad boy!")
                return
              end
              picker:action("explorer_del")
            end,
          },
        },
      },
    },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    scratch = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    terminal = { enabled = true, win = { border = "single" } },
    toggle = { enabled = true },
    words = { enabled = true },
    zen = { enabled = false },
  },
  keys = {
    {
      "<leader>tsb",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>tss",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      '<leader>"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.buffers({ filter = { cwd = true } })
      end,
      desc = "Buffers",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command history",
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers({ filter = { cwd = true } })
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find config file",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find git files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter = { cwd = true } })
      end,
      desc = "Find recent",
    },
    -- grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Search buffer lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers({ filter = { cwd = true } })
      end,
      desc = "Search open buffers",
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
      desc = "Search files",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.registers()
      end,
      desc = "Search registers",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Search autocmds",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Search command history",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Search commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Search diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Search help pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Search highlights",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Search jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Search keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Search location list",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Search man pages",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Search marks",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Search resume",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Search quickfix list",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Search projects",
    },
    {
      "<leader>sco",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Search colorschemes",
    },
    {
      "<leader>ny",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification history",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Buffer deletion",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gY",
      function()
        Snacks.gitbrowse.open({
          open = function(url)
            vim.fn.setreg("+", url)
            Snacks.notify("Copied git url to clipboard: " .. url)
          end,
        })
      end,
      desc = "Git copy url",
      mode = { "n", "v" },
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit current git file history",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gc",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit log (cwd)",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.explorer()
      end,
      desc = "Filetree explorer",
      mode = { "n" },
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Notifications dismissal",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev reference",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "Neovim news",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          border = "single",
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
        Snacks.terminal.toggle("zsh", { cwd = nil, win = { width = 0.7, height = 0.7 } })
      end,
      mode = { "n", "t" },
      desc = "Toggle terminal",
    },
    {
      "<leader>cl",
      function()
        Snacks.picker.lsp_config()
      end,
      desc = "LSP Information",
    },
    { "<c-h>", [[<C-\><C-n><C-W>h]], mode = "t", desc = "Window movement: move left" },
    { "<c-j>", [[<C-\><C-n><C-W>j]], mode = "t", desc = "Window movement: move down" },
    { "<c-k>", [[<C-\><C-n><C-W>k]], mode = "t", desc = "Window movement: move up" },
    { "<c-l>", [[<C-\><C-n><C-W>l]], mode = "t", desc = "Window movement: move right" },
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
        Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us", { desc = "Toggle spelling" })
        Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw", { desc = "Toggle word wrap" })
        Snacks.toggle
          .option("relativenumber", { name = "relative number" })
          :map("<leader>urn", { desc = "Toggle relative number" })
        Snacks.toggle.diagnostics():map("<leader>ud", { desc = "Toggle diagnostics" })
        Snacks.toggle.line_number():map("<leader>ul", { desc = "Toggle line numbers" })
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc", { desc = "Toggle conceallevel" })
        Snacks.toggle.treesitter():map("<leader>uT", { desc = "Toggle treesitter highlights" })
        Snacks.toggle.inlay_hints():map("<leader>uh", { desc = "Toggle inlay hints" })
        Snacks.toggle.indent():map("<leader>ug", { desc = "Toggle indent guides" })
        Snacks.toggle.dim():map("<leader>uD", { desc = "Toggle dimming" })
      end,
    })
  end,
}
