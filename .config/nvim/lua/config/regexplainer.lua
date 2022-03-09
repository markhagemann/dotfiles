-- defaults
require("regexplainer").setup({
  -- 'narrative'
  mode = "narrative", -- TODO: 'ascii', 'graphical'

  -- automatically show the explainer when the cursor enters a regexp
  auto = true,

  -- Whether to log debug messages
  debug = false,

  -- 'split', 'popup'
  display = "popup",

  mappings = {
    -- toggle = 'gR',
    -- show = 'gS',
    -- hide = 'gH',
    -- showSplit = 'gP',
    -- showPopup = 'gU',
  },

  narrative = {
    separator = "\n",
  },
})
