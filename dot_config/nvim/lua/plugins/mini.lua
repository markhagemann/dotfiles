return {

  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "echasnovski/mini.hipatterns",
    event = "VimEnter",
    version = "*",
    config = function()
      local hipatterns = require("mini.hipatterns")
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
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function()
      require("mini.icons").setup({
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
    end,
  },
  -- { "echasnovski/mini.indentscope", version = "*", event = "BufEnter" },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "BufEnter",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
