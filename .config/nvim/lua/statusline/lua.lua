local gl = require('galaxyline')
local gls = gl.section
local fn = vim.fn
gl.short_line_list = {'LuaTree','vista','dbui'}

local checkwidth = function()
  local squeeze_width  = fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

local colors = {
--  bg = '#202734',
  bg = '#262f40',
  yellow = '#fabd2f',
  cyan = '#4dbcd6',
  darkblue = '#081633',
  green = '#608B4E',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#569CD6',
  red = '#D16969'
}

local buffer_not_empty = function()
  if fn.empty(fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c= 'COMMAND',
          V= 'VISUAL',
          [''] = 'VISUAL',
          v ='VISUAL',
          c  = 'COMMAND-LINE',
          ['r?'] = ':CONFIRM',
          rm = '--MORE',
          R  = 'REPLACE',
          Rv = 'VIRTUAL',
          s  = 'SELECT',
          S  = 'SELECT',
          ['r']  = 'HIT-ENTER',
          [''] = 'SELECT',
          t  = 'TERMINAL',
          ['!']  = 'SHELL',
      }
      -- auto change color according the vim mode
      local mode_color = {n = colors.purple,
                          i = colors.green,
                          v = colors.blue,
                          [''] = colors.blue,
                          V = colors.blue,
                          c = colors.purple,
                          no = colors.magenta,
                          s = colors.orange,
                          S = colors.orange,
                          [''] = colors.orange,
                          ic = colors.yellow,
                          R = colors.red,
                          Rv = colors.red,
                          cv = colors.red,
                          ce=colors.red,
                          r = colors.cyan,
                          rm = colors.cyan,
                          ['r?'] = colors.cyan,
                          ['!']  = colors.red,
                          t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[fn.mode()])
      return ' NVCode '
    end,
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    -- separator = ' ',
    -- separator_highlight = {colors.yellow,function()
      -- if not buffer_not_empty() then
      --   return colors.bg
      -- end
      -- return colors.bg
    -- end},
    highlight = {colors.grey,colors.bg,'bold'},
  },
}
gls.left[2] ={
  FileIcon = {
    -- separator = '',
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}
gls.left[3] = {
 FileName = {
    provider = function()
      return fn.expand("%:F")
    end,
    condition = buffer_not_empty,
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.cyan, colors.bg, "bold"}
  }
}
gls.left[4] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange,colors.bg},
  }
}
gls.left[5] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = ' ',
    separator_highlight = {colors.darkblue,colors.bg},
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.bg},
  }
}
gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    -- separator = ' | ',
    -- separator_highlight = {colors.darkblue,colors.bg},
    icon = '   ',
    highlight = {colors.green,colors.bg},
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    -- separator = ' | ',
    -- separator_highlight = {colors.darkblue,colors.bg},
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    -- separator = ' | ',
    -- separator_highlight = {colors.darkblue,colors.bg},
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
}
gls.left[10] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.bg}
  }
}
gls.right[1] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.right[2] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}
gls.right[3] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '   ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.right[4] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '   ',
    highlight = {colors.orange,colors.bg},
  }
}
gls.right[5] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.cyan,colors.bg}
  }
}
gls.right[6] = {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.grey,colors.bg},
  }
}
gls.right[7] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.grey,colors.bg},
  },
}
gls.right[8] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' |',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.grey,colors.bg},
  }
}
gls.right[9] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.yellow,colors.purple},
  }
}
gls.short_line_left[1] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.bg}
  }
}
