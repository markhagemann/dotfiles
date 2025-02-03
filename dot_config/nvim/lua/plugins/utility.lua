return {
  { "arthurxavierx/vim-caser", event = "BufEnter" },
  {
    "barrett-ruth/import-cost.nvim",
    event = "BufEnter",
    build = "sh install.sh yarn",
    -- if on windows
    -- build = 'pwsh install.ps1 yarn',
    config = function()
      require("import-cost").setup({})
    end,
  },
  {
    "bloznelis/before.nvim",
    event = "BufEnter",
    config = function()
      local before = require("before")
      before.setup()

      -- Jump to previous entry in the edit history
      vim.keymap.set("n", "<leader>jl", before.jump_to_last_edit, { desc = "Jump to Last Edit" })

      -- Jump to next entry in the edit history
      vim.keymap.set("n", "<leader>jn", before.jump_to_next_edit, { desc = "Jump to Next Edit" })

      -- Look for previous edits in quickfix list
      vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, { desc = "Open Edits in Quickfix" })

      -- Look for previous edits in telescope (needs telescope, obviously)
      vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, { desc = "Open Edits in Telescope" })
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guifg = "#bb9af7", guibg = "#414868" },
            InclineNormalNC = { guifg = "#414868", guibg = "none" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    lazy = false,
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "BufEnter",
    keys = {
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Go to the previous pane" },
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to the left pane" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to the down pane" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to the up pane" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to the right pane" },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
  {
    "FabijanZulj/blame.nvim",
    opts = {},
    keys = {
      {
        "<leader>tb",
        "<CMD>BlameToggle<CR>",
        desc = "Open git blame list",
        noremap = true,
        silent = true,
      },
    },
    config = function(_, opts)
      require("blame").setup(opts)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TodoTrouble", "TroubleToggle" },
    event = "VimEnter",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    opts = {},
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "folke/twilight.nvim",
    opts = {},
    event = "VeryLazy",
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "toggle twilight" },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    keys = {
      -- suggested keymap
      { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
  {
    "harrisoncramer/gitlab.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim",
      "echasnovski/mini.icons",
    },
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
  {
    "kburdett/vim-nuuid",
    keys = {
      { "<leader>u", "<Plug>Nuuid", desc = "Create New UUID" },
    },
  },
  {
    "lewis6991/spaceless.nvim",
    event = { "BufLeave", "InsertEnter" },
    opts = {},
  },
  {
    "m4xshen/hardtime.nvim",
    event = "BufEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "TelescopePrompt",
        "aerial",
        "alpha",
        "checkhealth",
        "dapui*",
        "dbui",
        "Diffview*",
        "Dressing*",
        "grug-far",
        "help",
        "httpResult",
        "lazy",
        "mason",
        "minifiles",
        "Neogit*",
        "neo-tree",
        "neo-tree*",
        "neotest-summary",
        "netrw",
        "noice",
        "notify",
        "NvimTree",
        "prompt",
        "qf",
        "oil",
        "undotree",
        "Trouble",
      },

      max_count = 6,
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
    end,
    keys = {
      {
        "<leader>sr",
        ":GrugFar<cr>",
        desc = "search & replace across all files (Grug)",
      },
      {
        "<leader>sc",
        "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand(' % ') } })<cr>",
        desc = "search & replace across current file (Grug)",
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mappings = {
          t = { j = { false } }, --lazygit navigation fix
          v = { j = { k = false } }, -- visual select fix
        },
      })
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", ":UndotreeToggle<cr>", desc = "undo tree" },
    },
  },
  {
    "nmac427/guess-indent.nvim",
    event = "BufEnter",
    config = function()
      require("guess-indent").setup({
        auto_cmd = false, -- Set to false to disable automatic execution
      })
      vim.cmd([[ autocmd BufReadPost * :silent GuessIndent ]])
      vim.keymap.set("n", "<Tab>g", vim.cmd.GuessIndent, { desc = "GuessIndent (manual)" })
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
    },
  },
  { "preservim/vim-pencil", event = "VeryLazy" },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
      transparency_color = "#000000",
    },
  },
  {
    "rmagatti/auto-session", -- auto save session
    event = "VeryLazy",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = {
          "~/",
          "~/Downloads",
          "~/Documents",
        },
        auto_session_use_git_branch = true,
        auto_save_enabled = true,
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    opts = {
      delay = 200,
      filetypes_denylist = {
        "NvimTree",
      },
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      vim.cmd("hi IlluminatedWordText guibg=none gui=underline")
      vim.cmd("hi IlluminatedWordRead guibg=none gui=underline")
      vim.cmd("hi IlluminatedWordWrite guibg=none gui=underline")

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({

        chunk = {
          enable = true,
          priority = 15,
          style = {
            { fg = "#b46eff" },
            { fg = "#c21f30" },
          },
          use_treesitter = true,
          chars = {
            left_arrow = "─",
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          textobject = "",
          max_file_size = 1024 * 1024,
          error_sign = true,
          duration = 200,
          delay = 300,
        },
        indent = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          enable = false,
        },
      })
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    tag = "v0.4.1",
    event = "BufEnter",
    opts = {
      cursor_color = "#5f87cd",
      stiffness = 0.9,
      trailing_stiffness = 0.6,
      gamma = 0.25,
    },
  },
  { "sitiom/nvim-numbertoggle", event = "BufEnter" },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
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
  -- Sets yaml indentation wrong - guess indent fixes
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "volskaya/windovigation.nvim",
    lazy = false,
    opts = {},
  },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "ziontee113/color-picker.nvim",
    event = "BufEnter",
    config = function()
      local opts = { noremap = true, silent = true, desc = "pick colour" }
      vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<cr>", opts)
      require("color-picker").setup({
        ["icons"] = { "-", "" },
      })
    end,
  },
}
