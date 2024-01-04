local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" ↙ %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "UfoFoldedEllipsis" })
  return newVirtText
end

-- local ftMap = {
--   go = "lsp",
-- }

return {
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")

          require("statuscol").setup({
            relculright = true,
            bt_ignore = { "nofile", "prompt", "terminal", "packer" },
            ft_ignore = {
              "NvimTree",
              "dashboard",
              "nvcheatsheet",
              "dapui_watches",
              "dap-repl",
              "dapui_console",
              "dapui_stacks",
              "dapui_breakpoints",
              "dapui_scopes",
              "help",
              "vim",
              "alpha",
              "dashboard",
              "neo-tree",
              "Trouble",
              "noice",
              "lazy",
              "nvdash",
              "toggleterm",
            },
            segments = {
              -- Segment: Add padding
              {
                text = { " " },
              },
              -- Segment: Fold Column
              {
                text = { builtin.foldfunc },
                click = "v:lua.ScFa",
                maxwidth = 1,
                colwidth = 1,
                auto = false,
              },
              -- Segment: Add padding
              {
                text = { " " },
              },
              -- Segment : Show signs with one character width
              {
                sign = {
                  name = { ".*" },
                  -- name = {
                  --   "Dap",
                  --   "neotest",
                  --   "Diagnostic",
                  -- },
                  maxwidth = 1,
                  colwidth = 1,
                },
                auto = true,
                click = "v:lua.ScSa",
              },
              -- Segment: Show line number
              {
                text = { " ", " ", builtin.lnumfunc, " " },
                click = "v:lua.ScLa",
                condition = { true, builtin.not_empty },
              },
              -- Segment: GitSigns exclusive
              {
                sign = {
                  namespace = { "gitsign.*" },
                  maxwidth = 1,
                  colwidth = 1,
                  auto = false,
                },
                click = "v:lua.ScSa",
              },
              -- Segment: Add padding
              {
                text = { " " },
                hl = "Normal",
                condition = { true, builtin.not_empty },
              },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "nvcheatsheet", "NvimTree", "Outline" },
        callback = function()
          require("ufo").detach()
          vim.opt_local.foldenable = false
          vim.wo.foldcolumn = "0"
        end,
      })

      require("ufo").setup({
        close_fold_kinds = { "imports" },
        fold_virt_text_handler = handler,
        provider_selector = function(_, filetype, buftype)
          -- use nested markdown folding
          if filetype == "markdown" then
            return ""
          end

          -- return ftMap[filetype] or { "treesitter", "indent" }
          -- return { "treesitter", "indent" }
          local function handleFallbackException(bufnr, err, providerName)
            if type(err) == "string" and err:match("UfoFallbackException") then
              return require("ufo").getFolds(bufnr, providerName)
            else
              return require("promise").reject(err)
            end
          end

          -- only use indent until a file is opened
          return (filetype == "" or buftype == "nofile") and "indent"
              or function(bufnr)
                return require("ufo")
                    .getFolds(bufnr, "lsp")
                    :catch(function(err)
                      return handleFallbackException(bufnr, err, "treesitter")
                    end)
                    :catch(function(err)
                      return handleFallbackException(bufnr, err, "indent")
                    end)
              end
        end,
      })
      vim.keymap.set("n", "zO", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zC", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },
}
