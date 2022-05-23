require("e-kaput").setup({
  enabled = true, -- true | false,  Enable EKaput.
  transparency = 25, -- 0 - 100 , transparecy percentage.
  borders = false, -- true | false, Borders.
  error_sign = "", -- Error sign.
  warning_sign = "", -- Information sign.
  hint_sign = "", -- Hint sign.
  information_sign = "",
})

vim.cmd([[
  highlight link EKaputError Error
  highlight link EKaputWarning Warning
  highlight link EKaputInformation Information
  highlight link EKaputHint Hint
  highlight link EKaputBorder FloatBorder
  highlight link EKaputBackground MatchBackground
]])
