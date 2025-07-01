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
