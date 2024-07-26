return {
  "freddiehaddad/feline.nvim",
  event = "VeryLazy",
  config = function()
    local feline = require("feline")
    local colors = require("utils.colors")

    local theme = {
      fg = "#c7cde7",
      bg = "none",
      black = "#1e2327",
      green = "#98c379",
      yellow = "#e5c07b",
      dark_purple = "#7b38c9",
      orange = "#d19a66",
      peanut = "#f6d5a4",
      red = "#ff6c95",
      purple = "#9f7afc",
      pink = "#f4afd1",
      aqua = "#61afef",
      blue = "#429ef5",
      darkblue = "#282c34",
      dark_red = "#70260d",
      grey = "#313244",
      dark_grey = "#1D1D2E",
    }

    local vi_mode_colors = {
      NORMAL = colors.vi_mode_colors.normal,
      OP = colors.vi_mode_colors.normal,
      INSERT = colors.vi_mode_colors.insert,
      VISUAL = colors.vi_mode_colors.visual,
      LINES = colors.vi_mode_colors.visual,
      BLOCK = "dark_red",
      REPLACE = "red",
      COMMAND = colors.vi_mode_colors.command,
      TERM = colors.vi_mode_colors.terminal,
      -- V-REPLACE = "pink",
      -- ENTER = "pink",
      -- MORE = "pink",
      -- SELECT = "darkred",
      -- SHELL = "cyan",
      -- NONE = "gray",
    }

    local modes = setmetatable({
      ["n"] = "NORMAL",
      ["no"] = "N",
      ["v"] = "VISUAL",
      ["V"] = "VISUAL LINES",
      [""] = "VISUAL BLOCK",
      ["s"] = "S",
      ["S"] = "SL",
      [""] = "SB",
      ["i"] = "INSERT",
      ["ic"] = "I",
      ["R"] = "REPLACE",
      ["Rv"] = "VISUAL REPLACE",
      ["c"] = "COMMAND",
      ["cv"] = "EX",
      ["ce"] = "X",
      ["r"] = "P",
      ["rm"] = "M",
      ["r?"] = "C",
      ["!"] = "SH",
      ["t"] = "TERMINAL",
    }, {
      __index = function()
        return "-"
      end,
    })

    local c = {
      vim_mode = {
        provider = function()
          return modes[vim.api.nvim_get_mode().mode]
        end,
        hl = function()
          return {
            bg = "bg",
            fg = require("feline.providers.vi_mode").get_mode_color(),
            style = "bold",
            name = "NeovimModeHLColor",
          }
        end,
        left_sep = "",
        right_sep = " ",
      },
      gitBranch = {
        provider = "git_branch",
        hl = {
          fg = "peanut",
          bg = "bg",
          -- style = "bold",
        },
        left_sep = "",
        right_sep = "",
      },
      gitDiffAdded = {
        provider = "git_diff_added",
        hl = {
          fg = "green",
          bg = "bg",
        },
        left_sep = "",
        right_sep = "",
      },
      gitDiffRemoved = {
        provider = "git_diff_removed",
        hl = {
          fg = "red",
          bg = "bg",
        },
        left_sep = "",
        right_sep = "",
      },
      gitDiffChanged = {
        provider = "git_diff_changed",
        hl = {
          fg = "fg",
          bg = "bg",
        },
        left_sep = "",
        right_sep = "",
      },
      separator = {
        provider = "",
      },
      fileinfo = {
        provider = {
          name = "file_info",
        },
        -- hl = {
        --   style = "bold",
        -- },
        left_sep = " ",
        right_sep = " ",
      },
      diagnostic_errors = {
        provider = "diagnostic_errors",
        hl = {
          fg = "red",
        },
        left_sep = "",
        right_sep = "",
      },
      diagnostic_warnings = {
        provider = "diagnostic_warnings",
        hl = {
          fg = "yellow",
        },
        left_sep = "",
        right_sep = "",
      },
      diagnostic_hints = {
        provider = "diagnostic_hints",
        hl = {
          fg = "aqua",
        },
        left_sep = "",
        right_sep = "",
      },
      diagnostic_info = {
        provider = "diagnostic_info",
        left_sep = "",
        right_sep = "",
      },
      lsp = {
        provider = function()
          if not rawget(vim, "lsp") then
            return ""
          end

          local progress = vim.lsp.status()[1]
          if vim.o.columns < 120 then
            return ""
          end

          local clients = vim.lsp.get_active_clients({ bufnr = 0 })
          if #clients ~= 0 then
            if progress then
              local spinners = {
                "◜ ",
                "◠ ",
                "◝ ",
                "◞ ",
                "◡ ",
                "◟ ",
              }
              local ms = vim.loop.hrtime() / 1000000
              local frame = math.floor(ms / 120) % #spinners
              local content = string.format("%%<%s", spinners[frame + 1])
              return content or ""
            else
              return "לּ LSP"
            end
          end
          return ""
        end,
        hl = function()
          local progress = vim.lsp.status()[1]
          return {
            fg = progress and "darkblue" or "blue",
            bg = "bg",
            -- style = "bold",
          }
        end,
        left_sep = " ",
        right_sep = "",
      },
      -- file_type = {
      --   provider = {
      --     name = "file_type",
      --     opts = {
      --       filetype_icon = true,
      --       case = "lowercase",
      --     },
      --   },
      --   hl = {
      --     fg = "fg",
      --     bg = "bg",
      --     -- style = "bold",
      --   },
      --   left_sep = " ",
      --   right_sep = "",
      -- },
      -- file_encoding = {
      --   provider = "file_encoding",
      --   hl = {
      --     fg = "orange",
      --     bg = "darkblue",
      --     style = "italic",
      --   },
      --   left_sep = " ",
      --   right_sep = " ",
      -- },
      position = {
        provider = "position",
        hl = {
          fg = "green",
          bg = "bg",
          -- style = "bold",
        },
        left_sep = " ",
        right_sep = "",
      },
      scroll_bar = {
        provider = function()
          local chars = setmetatable({
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
          }, {
            __index = function()
              return " "
            end,
          })
          local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
          local position = math.floor(line_ratio * 100)

          local icon = chars[math.floor(line_ratio * #chars)] .. position
          if position <= 5 then
            icon = " TOP"
          elseif position >= 95 then
            icon = " BOT"
          end
          return icon
        end,
        hl = function()
          local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
          local fg
          local bg
          local style

          if position <= 5 then
            fg = "pink"
            style = "bold"
          elseif position >= 95 then
            fg = "aqua"
            style = "bold"
          else
            fg = "purple"
            style = nil
          end
          return {
            fg = fg,
            style = style,
            bg = "bg",
          }
        end,
        left_sep = " ",
        right_sep = "",
      },
    }

    local left = {
      c.vim_mode,
      c.gitBranch,
      c.gitDiffAdded,
      c.gitDiffRemoved,
      c.gitDiffChanged,
      c.separator,
    }

    local middle = {
      c.fileinfo,
      c.diagnostic_errors,
      c.diagnostic_warnings,
      c.diagnostic_info,
      c.diagnostic_hints,
    }

    local right = {
      c.lsp,
      -- c.file_type,
      -- c.file_encoding,
      c.position,
      c.scroll_bar,
    }

    local components = {
      active = {
        left,
        middle,
        right,
      },
      inactive = {
        left,
        middle,
        right,
      },
    }

    feline.setup({
      components = components,
      disable = {
        filetypes = {
          -- "NvimTree",
          -- "Outline",
          -- "dap-repl",
          -- "dapui_scopes",
          -- "dapui_stacks",
          -- "dapui_watches",
          -- "dapui_repl",
          -- "Trouble",
          -- "qf",
          -- "help",
        },
      },
      theme = theme,
      vi_mode_colors = vi_mode_colors,
    })
  end,
}
