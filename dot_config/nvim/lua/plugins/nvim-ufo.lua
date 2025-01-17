local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" ↙ %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk1
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk2
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
      "luukvbaal/statuscol.nvim",
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
        -- close_fold_kinds = { "imports" },
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
