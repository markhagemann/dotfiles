return {
  {
    "echasnovski/mini.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    lazy = false,
    version = "*",
    config = function()
      require("mini.ai").setup()
      local clue = require("mini.clue")
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = {
            add = "▎",
            change = "▎",
            delete = "▎",
          },
        },
      })
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
      local files = require("mini.files")
      require("mini.git").setup()
      local hipatterns = require("mini.hipatterns")
      local icons = require("mini.icons")
      require("mini.move").setup()
      require("mini.pairs").setup({
        mappings = {
          -- Prevents the action if the cursor is just before any character or next to a "\".
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][%s%)%]%}]" },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][%s%)%]%}]" },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][%s%)%]%}]" },
          -- This is default (prevents the action if the cursor is just next to a "\").
          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
          -- Prevents the action if the cursor is just before or next to any character.
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w][^%w]", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
        },
      })
      require("mini.surround").setup()

      clue.setup({
        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<leader>" },
          { mode = "x", keys = "<leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "x", keys = "'" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        window = {
          delay = 100,
        },
      })

      files.setup({
        mappings = {
          close = "q",
          go_in_entry = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
          reset = "<BS>",
          reveal_cwd = ".",
          show_help = "g?",
          synchronize = "s",
          trim_left = "<",
          trim_right = ">",
        },
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 80,
        },
        options = {
          use_as_default_explorer = true,
          permanent_delete = true,
        },
      })

      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME:', 'HACK:', 'TODO:', 'NOTE:'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      icons.setup({
        filetype = {
          json = { glyph = "" },
          jsonc = { glyph = "" },

          sh = { glyph = "󰐣", hl = "MiniIconsBlue" },
          zsh = { glyph = "󰐣" },
          bash = { glyph = "󰐣" },
        },
        extension = {
          conf = { glyph = "󰛸", hl = "MiniIconsBlue" },
        },
      })
      MiniIcons.mock_nvim_web_devicons()
    end,
    keys = {
      {
        -- Open the directory of the file currently being edited
        -- If the file doesn't exist because you maybe switched to a new git branch
        -- open the current working directory
        "<leader>f-",
        function()
          local buf_name = vim.api.nvim_buf_get_name(0)
          local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
          if vim.fn.filereadable(buf_name) == 1 then
            -- Pass the full file path to highlight the file
            require("mini.files").open(buf_name, true)
          elseif vim.fn.isdirectory(dir_name) == 1 then
            -- If the directory exists but the file doesn't, open the directory
            require("mini.files").open(dir_name, true)
          else
            -- If neither exists, fallback to the current working directory
            require("mini.files").open(vim.uv.cwd(), true)
          end
        end,
        desc = "open mini files (directory of current file or cwd if not exists)",
      },
      -- Open the current working directory
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "open mini files (cwd)",
      },
    },
  },
}
