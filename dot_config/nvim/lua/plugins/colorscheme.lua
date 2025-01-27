return {
  {
    "folke/tokyonight.nvim",
    branch = "main",
    lazy = false,
    priority = 1000,
    config = function()
      -- Initialize transparency state if it doesn't exist
      vim.g.transparent_enabled = vim.g.transparent_enabled or false

      -- Function to configure and apply the theme dynamically
      _G.configure_tokyonight = function()
        local is_transparent = vim.g.transparent_enabled

        -- Setup the theme with the current transparency state
        require("tokyonight").setup({
          style = "moon", -- You can switch to "night", "day", etc.
          transparent = is_transparent,
          styles = {
            sidebars = "transparent",
            floats = is_transparent and "transparent" or "dark",
          },
        })

        -- Apply the theme
        vim.cmd("colorscheme tokyonight")

        -- Directly apply transparency or solid background based on the state
        if is_transparent then
          -- Set transparent background
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
          vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
          vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
        else
          -- Set solid background for non-transparent
          vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
        end
      end

      -- Apply initial configuration
      configure_tokyonight()
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      -- Function to toggle transparency
      local toggle_transparency = function()
        -- Toggle the transparency flag
        vim.g.transparent_enabled = not vim.g.transparent_enabled

        -- Print transparency state for debugging
        print("Transparency enabled:", vim.g.transparent_enabled)

        -- Reapply theme and background based on the updated transparency state
        configure_tokyonight()
      end

      -- Set the keybinding to toggle transparency
      vim.keymap.set("n", "<leader>tt", toggle_transparency, { desc = "Toggle transparency" })
    end,
  },
  {
    "mawkler/modicator.nvim",
    event = "BufEnter",
    after = "folke/tokyonight.nvim",
    config = function()
      local colors = require("utils.colors")
      local modes = {
        "Normal",
        "Insert",
        "Visual",
        "Command",
        "Replace",
        "Select",
        "Terminal",
        "TerminalNormal",
      }

      for _, mode in pairs(modes) do
        local fg_color = colors.vi_mode_colors[mode:lower()]
        vim.api.nvim_set_hl(0, mode .. "Mode", { fg = fg_color })
      end

      require("modicator").setup({
        show_warnings = false,
        highlights = {
          defaults = {
            bold = false,
          },
        },
      })
    end,
  },
}
