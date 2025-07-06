return {
  "karb94/neoscroll.nvim",
  event = "BufEnter",
  opts = {},
  config = function()
    local function rel_time(n)
      local win_height = vim.fn.winheight(0)
      n = n or win_height
      if n % 1 ~= 0 then
        n = n * win_height
      end
      -- n is the numof lines we want to scroll
      local lines_ratio = n / win_height
      local threshold = 46 -- windows smaller thant this scroll faster
      local win_ratio = win_height / threshold
      local factor = win_ratio * lines_ratio
      local log_factor = 1 / math.log(1 / factor + 1, 2)
      local time = 300 * log_factor
      -- print(time)
      return time
    end

    local neoscroll = require("neoscroll")
    neoscroll.setup({
      mappings = {}, -- no default mappings
    })

    local function map_key(lhs, rhs)
      vim.keymap.set({ "x", "n" }, lhs, rhs)
    end

    map_key("<C-u>", function()
      neoscroll.scroll(-vim.wo.scroll, {
        move_cursor = true,
        duration = rel_time(vim.wo.scroll),
      })
    end)

    map_key("<C-d>", function()
      neoscroll.scroll(vim.wo.scroll, {
        move_cursor = true,
        duration = rel_time(vim.wo.scroll),
      })
    end)

    -- other mappings ...
    --
    -- map_key("zz", function()
    --   neoscroll.zz(rel_time(0.33))
    -- end)
  end,
}
