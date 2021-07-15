if not pcall(require, "fzf-lua") then
  return
end

local M = {}

-- require'fzf-lua'.setup({})
local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
  win_height          = 0.85,         -- window height
  win_width           = 0.80,         -- window width
  win_row             = 0.30,         -- window row position (0=top, 1=bottom)
  win_col             = 0.50,         -- window col position (0=left, 1=right)
  win_border          = true,         -- window border?
  fzf_layout          = 'reverse',    -- fzf '--layout='
  preview_cmd         = '',           -- 'head -n $FZF_PREVIEW_LINES',
  preview_border      = 'border',     -- border|noborder
  preview_wrap        = 'nowrap',     -- wrap|nowrap
  preview_vertical    = 'down:45%',   -- up|down:size
  preview_horizontal  = 'right:60%',  -- right|left:size
  preview_layout      = 'flex',       -- horizontal|vertical|flex
  flip_columns        = 120,          -- #cols to switch to horizontal on flex
  bat_theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
  bat_opts            = '--style=numbers,changes --color always',
  files = {
    prompt            = 'Files❯ ',
    cmd               = '',           -- "find . -type f -printf '%P\n'",
    git_icons         = true,         -- show git icons?
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["ctrl-q"]      = actions.file_sel_to_qf,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    }
  },
  grep = {
    prompt            = 'Rg❯ ',
    input_prompt      = 'Grep For❯ ',
    -- cmd               = "rg --vimgrep",
    git_icons         = true,         -- show git icons?
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["ctrl-q"]      = actions.file_sel_to_qf,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    }
  },
  oldfiles = {
    prompt            = 'History❯ ',
    cwd_only          = false,
  },
  git = {
    prompt            = 'GitFiles❯ ',
    cmd               = 'git ls-files --exclude-standard',
    git_icons         = true,         -- show git icons?
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
  },
  buffers = {
    prompt            = 'Buffers❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
      ["ctrl-x"]      = actions.buf_del,
    }
  },
  colorschemes = {
    prompt            = 'Colorschemes❯ ',
    live_preview      = true,
    actions = {
      ["default"]     = actions.colorscheme,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    },
    winopts = {
      win_height       = 0.55,
      win_width        = 0.30,
      window_on_create = function()
        vim.cmd("set winhl=Normal:Normal")
      end,
    },
    post_reset_cb    = function()
      require('feline').reset_highlights()
    end,
  },
  quickfix = {
    cwd               = vim.loop.cwd(),
    file_icons        = true,
  },
  -- placeholders for additional user customizations
  loclist = {},
  helptags = {},
  manpages = {},
  file_icon_colors = {                -- override colors for extensions
    ["lua"]   = "blue",
  },
  git_icons = {                       -- override colors for git icons
    ["M"]     = "M", --"★",
    ["D"]     = "D", --"✗",
    ["A"]     = "A", --"+",
    ["?"]     = "?"
  },
  git_icon_colors = {                 -- override colors for git icon colors
    ["M"]     = "yellow",
    ["D"]     = "red",
    ["A"]     = "green",
    ["?"]     = "magenta"
  },
  fzf_binds           = {             -- fzf '--bind=' options
    'f2:toggle-preview',
    'f3:toggle-preview-wrap',
    'shift-down:preview-page-down',
    'shift-up:preview-page-up',
    'ctrl-d:half-page-down',
    'ctrl-u:half-page-up',
    'ctrl-f:page-down',
    'ctrl-b:page-up',
    'ctrl-a:toggle-all',
    'ctrl-u:clear-query',
  },
  window_on_create = function()         -- nvim window options override
    vim.cmd("set winhl=Normal:Normal")  -- popup bg match normal windows
  end
}

function M.edit_neovim(opts)
  if not opts then opts = {} end
  opts.prompt = "< VimRC > "
  opts.cwd = "$HOME/.config/nvim"
  require'fzf-lua'.files(opts)
end

function M.edit_dotfiles(opts)
  if not opts then opts = {} end
  opts.prompt = "~ dotfiles ~ "
  opts.cwd = "~/dots"
  require'fzf-lua'.files(opts)
end

function M.edit_zsh(opts)
  if not opts then opts = {} end
  opts.prompt = "~ zsh ~ "
  opts.cwd = "$HOME/.config/zsh"
  require'fzf-lua'.files(opts)
end

function M.installed_plugins(opts)
  if not opts then opts = {} end
  opts.prompt = 'Plugins❯ '
  opts.cwd = vim.fn.stdpath "data" .. "/site/pack/packer/"
  require'fzf-lua'.files(opts)
end


FzfMapArgs = FzfMapArgs or {}

local map_fzf = function(mode, key, f, options, buffer)
  local map_fzf = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  FzfMapArgs[map_fzf] = options or {}

  local rhs = string.format([[<cmd>lua require'utils'.ensure_loaded_fnc(]] ..
    [[ {'nvim-fzf','fzf-lua'}, function()]] ..
    [[ require('plugin.fzf-lua')['%s'](FzfMapArgs['%s'])]] ..
    [[ end)<CR>]]
    , f, map_fzf)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

-- mappings
map_fzf('n', '<F1>', "help_tags")
map_fzf('n', '<c-P>', "files", {})
map_fzf('n', '<leader>,', "buffers")
map_fzf('n', '<leader>zr', "grep", {})
map_fzf('n', '<leader>zl', "live_grep", {})
map_fzf('n', '<leader>zR', "live_grep", {})
map_fzf('n', '<leader>zz', "grep", { repeat_last_search = true} )
map_fzf('n', '<leader>zw', "grep_cword")
map_fzf('n', '<leader>zW', "grep_cWORD")
map_fzf('n', '<leader>zv', "grep_visual")
map_fzf('v', '<leader>zv', "grep_visual")
map_fzf('n', '<leader>zb', "grep_curbuf", { prompt = 'Buffer❯ ' })
map_fzf('n', '<leader>zf', "files", {})
map_fzf('n', '<leader>zg', "git_files", {})
map_fzf('n', '<leader>zh', "oldfiles")
map_fzf('n', '<leader>zq', "quickfix")
map_fzf('n', '<leader>zQ', "loclist")
map_fzf('n', '<leader>zo', "colorschemes")
map_fzf('n', '<leader>zM', "man_pages")

-- Nvim & Dots
map_fzf('n', '<leader>en', "edit_neovim")
map_fzf('n', '<leader>ed', "edit_dotfiles")
map_fzf('n', '<leader>ez', "edit_zsh")
map_fzf('n', '<leader>ep', "installed_plugins")

--[[
map_fzf('n', '<leader>fc', "commands")
map_fzf('n', '<leader>fx', "command_history")
map_fzf('n', '<leader>fs', "search_history")
map_fzf('n', '<leader>fm', "marks")
map_fzf('n', '<leader>fR', "registers")
map_fzf('n', '<leader>fo', "vim_options")
map_fzf('n', '<leader>fk', "keymaps")
map_fzf('n', '<leader>fz', "spell_suggest")
map_fzf('n', '<leader>ft', "current_buffer_tags")
map_fzf('n', '<leader>fT', "tags")
-- Git
map_fzf('n', '<leader>fB', "git_branches")
map_fzf('n', '<leader>gB', "git_branches")
map_fzf('n', '<leader>gC', "git_commits")
-- LSP
map_fzf('n', '<leader>lr', "lsp_references")
map_fzf('n', '<leader>la', "lsp_code_actions")
map_fzf('n', '<leader>lA', "lsp_range_code_actions")
map_fzf('n', '<leader>ld', "lsp_definitions")
map_fzf('n', '<leader>lm', "lsp_implementations")
map_fzf('n', '<leader>lg', "lsp_document_diagnostics")
map_fzf('n', '<leader>lG', "lsp_workspace_diagnostics")
map_fzf('n', '<leader>ls', "lsp_document_symbols")
map_fzf('n', '<leader>lS', "lsp_workspace_symbols")
-- Telescope Meta
map_fzf('n', "<leader>f?", "builtin") ]]

return setmetatable({}, {
  __index = function(_, k)
    -- reloader()

    if M[k] then
      return M[k]
    else
      return require('fzf-lua')[k]
    end
  end,
})
