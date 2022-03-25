-- local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
  defaults = {
    preview = {
      treesitter = false,
    },
  },
  pickers = {
    buffers = {
      wrap_results = true,
      layout_config = { anchor = "N", prompt_position = "bottom", height = 0.4, width = 0.4 },
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["<c-d>"] = "delete_buffer",
        },
      },
    },
    find_files = {
      wrap_results = true,
      ignore = true,
      layout_config = { anchor = "N", prompt_position = "bottom", height = 0.4, width = 0.4 },
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      debounce = 100,
      layout_config = { anchor = "NW", prompt_position = "top", height = 0.9, width = 0.9 },
      layout_strategy = "horizontal",
    },
    mappings = { i = { ["<c-t>"] = trouble.open_with_trouble } },
    -- vimgrep_arguments = {
    --   "rg",
    --   "--color=never",
    --   "--no-heading",
    --   "--with-filename",
    --   "--line-number",
    --   "--column",
    --   "--smart-case",
    -- },
    prompt_prefix = " ",
    selection_caret = " ",

    file_ignore_patterns = {
      "node_modules",
      ".work/.*",
      ".cache/.*",
      ".idea/.*",
      "dist/.*",
      ".git/.*",
    },
    winblend = 10,
  },
})

telescope.load_extension("z")
telescope.load_extension("fzf")

local util = require("util")

util.nnoremap("<C-p>", function()
  require("telescope.builtin").find_files()
end)

util.nnoremap("<leader>fz", function()
  require("telescope").extensions.z.list({ cmd = { vim.o.shell, "-c", "zoxide query -ls" } })
end)

util.nnoremap("<leader>pp", ":lua require'telescope'.extensions.project.project{}<CR>")

return M
