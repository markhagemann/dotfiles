local files = require("overseer.files")

-- Recursively list all files in a directory and its subdirectories
local function find_shell_script_files(base_dir)
  local dirs = { "bin", "scripts", "tools" }
  local all_files = {}

  for _, dir in ipairs(dirs) do
    local full_dir = files.join(base_dir, dir)
    if vim.fn.isdirectory(full_dir) == 1 then
      -- Use vim.fn.glob to find all files recursively in the directory and subdirectories
      local file_list = vim.fn.glob(full_dir .. "/**/*", true, true)
      -- Add all found files to the all_files list
      for _, filename in ipairs(file_list) do
        -- Convert absolute path to relative path by removing the base_dir portion
        local relative_path = filename:sub(#base_dir + 2)
        table.insert(all_files, relative_path)
      end
    end
  end

  return all_files
end

return {
  generator = function(opts, cb)
    local base_dir = vim.fn.getcwd() -- Get the current working directory

    -- Find all files within the bin, scripts, and tools directories recursively
    local all_files = find_shell_script_files(base_dir)

    -- Debugging: Print the list of all detected files
    -- print("All detected files:", vim.inspect(all_files))

    -- Filter the files to include only .sh files or files with no extension
    local scripts = vim.tbl_filter(function(filename)
      -- Match .sh extension or files with no extension
      return filename:match("%.sh$") or filename:match("^[^.]+$")
    end, all_files)

    -- Debugging: Print the filtered script files
    -- print("Filtered scripts:", vim.inspect(scripts))

    -- Prepare tasks for Overseer
    local ret = {}
    for _, filename in ipairs(scripts) do
      -- Debug: Print task creation info
      -- print("Creating task for:", filename)

      -- Add a parameter for extra input (args), which will be prompted when the task runs
      table.insert(ret, {
        name = filename,
        params = {
          args = {
            type = "list",
            delimiter = " ",
            prompt = "Provide additional arguments (space-separated): ",
            default = {}, -- Set to an empty list by default
          },
        },
        builder = function(params)
          return {
            cmd = { files.join(base_dir, filename) },
            args = params.args, -- The args that the user enters will be passed here
          }
        end,
      })
    end

    -- Debugging: Print final tasks to be returned
    -- print("Returning tasks:", vim.inspect(ret))

    -- Return the tasks to Overseer
    cb(ret)
  end,
}
