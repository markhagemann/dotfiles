local wk = require("which-key")
local util = require("util")

vim.o.timeoutlen = 300

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil
wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

-- Edit Vim config file in a new tab.
util.nmap("<leader>ev", ":tabnew $MYVIMRC<CR>")

-- Remap macro record key
util.nmap("Q", "q")
util.nmap("q", "<Nop>")

-- Allow for delete and paste to not replace my existing register
-- util.nmap("d", '"_d')
-- util.vmap("d", '"_d')
-- util.xmap("d", '"_d')
-- util.xmap("p", '"_dP')

-- Update shiftwidth
util.nmap("<leader>sw2", ":set shiftwidth=2<CR>")
util.nmap("<leader>sw4", ":set shiftwidth=4<CR>")

-- Resize window using <ctrl> arrow keys
util.nnoremap("<C-k>", ":resize +2<CR>")
util.nnoremap("<C-j>", ":resize -2<CR>")
util.nnoremap("<C-h>", ":vertical resize -2<CR>")
util.nnoremap("<C-l>", ":vertical resize +2<CR>")

-- Move Lines
util.nnoremap("<A-j>", ":m .+1<CR>==")
util.vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
util.inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
util.nnoremap("<A-k>", ":m .-2<CR>==")
util.vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
util.inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- Switch buffers with tab
util.nnoremap("H", ":bprevious<cr>")
util.nnoremap("L", ":bnext<cr>")

-- Easier pasting
util.nnoremap("[p", ":pu!<cr>")
util.nnoremap("]p", ":pu<cr>")

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.onoremap("N", "'nN'[v:searchforward]", { expr = true })

-- telescope <ctrl-r> in command line
-- vim.cmd([[cmap <C-R> <Plug>(TelescopeFuzzyCommandSearch)]])

-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
util.nmap("<leader>r", ":%s///g<Left><Left><Left>")
util.nmap("<leader>rc", ":%s///gc<Left><Left><Left><Left>")

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range. You can do that by
-- pressing *, visually selecting the range you want it to apply to and then
-- press a key below to replace all instances of it in the current selection.
util.nmap("<leader>r", ":%s///g<Left><Left><Left>")
util.nmap("<leader>rc", ":%s///gc<Left><Left><Left><Left>")

-- Konfekt/vim-scratchpad
util.nmap("<leader>dsp", ":<c-u>call scratchpad#ToggleScratchPad(g:scratchpad_ftype)<CR>")

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

local leader = {
  ["w"] = {
    name = "+windows",
    ["w"] = { "<C-W>p", "other-window" },
    ["d"] = { "<C-W>c", "delete-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["J"] = { ":resize +5", "expand-window-below" },
    ["L"] = { "<C-W>5>", "expand-window-right" },
    ["K"] = { ":resize -5", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  c = { v = { "<cmd>Vista!!<CR>", "Vista" }, o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" } },
  b = {
    name = "+buffer",
    ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
    ["d"] = { "<cmd>:bd<CR>", "Delete Buffer" },
  },
  d = {
    name = "+debugging",
    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
    ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
    ["b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    ["B"] = {
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "Set Breakpoint Condition",
    },
    ["L"] = {
      "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      "Log point message",
    },
    ["e"] = { "<cmd>lua require'dap'.set_exception_breakpoints({'all'})<CR>", "Set Exception Breakpoint" },
    ["r"] = { "<cmd>lua require'dap'.repl_open({}, 'vsplit')<CR><C-w>l", "Repl Open" },
    ["l"] = { "<cmd>lua require'dap'.run_last()<CR>", "Run Last" },
    ["h"] = {
      "<cmd>lua require'dap.ui.variables'.hover(function () return vim.fn.expand('<cexpr>') end)<CR>",
      "Hover",
    },
    ["v"] = { "<cmd>lua require'dap.ui.variables'.visual_hover()<CR>", "Visual Hover" },
    ["s"] = { "<cmd>lua require'dap.ui.variables'.scopes()<CR>", "Scopes" },
  },
  g = {
    name = "+git",
    g = { "<cmd>Neogit<CR>", "NeoGit" },
    l = {
      function()
        require("util").float_terminal("lazygit")
      end,
      "LazyGit",
    },
    c = { "<Cmd>Telescope git_commits<CR>", "commits" },
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    s = { "<Cmd>Telescope git_status<CR>", "status" },
    d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
    h = { name = "+hunk" },
  },
  ["h"] = {
    name = "+help",
    t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>:Telescope commands<cr>", "Commands" },
    h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
    l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
    p = {
      name = "+packer",
      p = { "<cmd>PackerSync<cr>", "Sync" },
      s = { "<cmd>PackerStatus<cr>", "Status" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      c = { "<cmd>PackerCompile<cr>", "Compile" },
    },
  },
  u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
  s = {
    name = "+search",
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Goto Symbol" },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
  },
  f = {
    name = "+file",
    t = { "<cmd>NvimTreeToggle<cr>", "NvimTreeToggle" },
    f = { "<cmd>NvimTreeFindFile<cr>", "NvimTreeFindFile" },
    p = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
    z = "Zoxide",
    d = "Dot Files",
  },
  o = {
    name = "+open",
    p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
    g = { "<cmd>Glow<cr>", "Markdown Glow" },
  },
  p = {
    name = "+project",
    p = "Open Project",
    b = { ":Telescope file_browser cwd=~/projects<CR>", "Browse ~/projects" },
  },
  t = {
    name = "toggle",
    f = {
      require("config.lsp.formatting").toggle,
      "Format on Save",
    },
    s = {
      function()
        util.toggle("spell")
      end,
      "Spelling",
    },
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
    n = {
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      "Line Numbers",
    },
  },
  -- ["<tab>"] = {
  --   name = "workspace",
  --   ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

  --   n = { "<cmd>tabnext<CR>", "Next" },
  --   d = { "<cmd>tabclose<CR>", "Close" },
  --   p = { "<cmd>tabprevious<CR>", "Previous" },
  --   ["]"] = { "<cmd>tabnext<CR>", "Next" },
  --   ["["] = { "<cmd>tabprevious<CR>", "Previous" },
  --   f = { "<cmd>tabfirst<CR>", "First" },
  --   l = { "<cmd>tablast<CR>", "Last" },
  -- },
  ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
  ["p"] = "Find File",
  ["."] = { ":Telescope file_browser<CR>", "Browse Files" },
  [","] = { "<cmd>Telescope buffers<cr>", "Switch Buffer" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  q = {
    name = "+quit/session",
    q = { "<cmd>:qa<cr>", "Quit" },
    ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
    s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
    l = { [[<cmd>lua require("persistence").load({last=true})<cr>]], "Restore Last Session" },
    d = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Current Session" },
  },
  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    -- w = { "<cmd>TroubleWorkspaceToggle<cr>", "Workspace Trouble" },
    d = { "<cmd>TroubleDocumentToggle<cr>", "Document Trouble" },
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
  },
  T = { [[<Plug>PlenaryTestFile]], "Plenary Test" },
  D = {
    function()
      util.docs()
    end,
    "Create Docs from README.md",
  },
  E = {
    [[<cmd>lua require"exec-cursorline-insert-stdout".execute{prepare_for_next_command = true}<cr>]],
    "Execute Cursorline",
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto", h = "Hop Word" }, s = "Hop Word1" })
