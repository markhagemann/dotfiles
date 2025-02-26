-- Taken from https://github.com/tigion/dotfiles/blob/main/nvim/lua/tigion/core/util.lua

local M = {}

---Returns the Neovim version as formatted string.
---@return string
function M.nvim_version()
  local version = vim.version()
  local v = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  -- if version.prerelease ~= nil then v = v .. '-' .. version.prerelease end
  return v
end

---Returns the plugin stats.
---@return table
function M.plugin_stats()
  local stats = require("lazy").stats()
  local updates = require("lazy.manage.checker").updated
  return {
    count = stats.count,
    loaded = stats.loaded,
    startuptime = (math.floor(stats.startuptime * 100 + 0.5) / 100),
    updates = #updates,
  }
end

function M.is_github_repo()
  -- Check if inside a git repository
  if Snacks.git.get_root() ~= nil then
    -- Get the remote URL
    local remote_url = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")
    -- Check if the URL contains "github.com"
    return remote_url:match("github.com") ~= nil
  end
  return false
end

-- Function to check if the current repository is on GitLab
function M.is_gitlab_repo()
  -- Check if inside a git repository
  if Snacks.git.get_root() ~= nil then
    -- Get the remote URL
    local remote_url = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")
    -- Check if the URL contains "gitlab.com"
    return remote_url:match("gitlab.com") ~= nil
  end
  return false
end

return M
