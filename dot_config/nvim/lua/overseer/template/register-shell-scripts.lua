local files = require("overseer.files")

-- Function to recursively find 'bin', 'scripts', or 'tools' directories and return their files
local function find_shell_script_files(base_dir)
  local dirs = { "bin", "scripts", "tools" } -- Directories we are interested in
  local excluded_dirs = { ".git", "node_modules", "ci" } -- Exclude these directories
  local all_files = {}

  -- Recursive function to walk through a directory and its subdirectories
  local function recursive_find(dir)
    -- Get all files and directories in the current directory
    local file_list = vim.fn.readdir(dir)

    -- Debugging: Print current directory being searched
    -- print("Searching in directory:", dir)

    for _, file in ipairs(file_list) do
      local full_path = files.join(dir, file)

      -- Skip excluded directories
      local skip = false
      for _, excluded in ipairs(excluded_dirs) do
        if file == excluded then
          skip = true
          break
        end
      end
      if skip then
        -- Debugging: Excluded directory
        -- print("Skipping excluded directory:", full_path)

        goto continue -- Skip this directory
      end

      -- Check if this directory is inside a valid 'bin', 'scripts', or 'tools' directory
      local is_valid_dir = false
      for _, target_dir in ipairs(dirs) do
        if string.find(full_path, target_dir) then
          is_valid_dir = true
          break
        end
      end

      -- If it's a directory and matches our valid directories, process it
      if vim.fn.isdirectory(full_path) == 1 then
        if is_valid_dir then
          -- Debugging: Print found directory
          -- print("Found valid directory:", full_path)

          -- Now look for all the files in this directory (recursively)
          local files_in_dir = vim.fn.readdir(full_path) -- Get files in this directory
          for _, f in ipairs(files_in_dir) do
            local file_path = files.join(full_path, f)
            -- Add files only (skip subdirectories)
            if vim.fn.filereadable(file_path) == 1 then
              table.insert(all_files, file_path) -- Add file path to all_files
            end
          end
        end

        -- Continue recursion into subdirectories after processing files in the current directory
        recursive_find(full_path) -- **Continue recursion here to process subdirectories**
      end

      ::continue::
    end
  end

  -- Start recursion from the base directory (current working directory)
  recursive_find(base_dir)

  return all_files
end

return {
  generator = function(opts, cb)
    local base_dir = vim.fn.getcwd() -- Get the current working directory

    -- Debugging: Print base directory
    -- print("Base directory:", base_dir)

    -- Find all files within the bin, scripts, tools directories recursively
    local all_files = find_shell_script_files(base_dir)

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
      -- Ensure the filename is relative to the base directory (current working directory)
      local relative_path = filename:sub(#base_dir + 2) -- Strip base_dir from the full path

      -- Debugging: Print task creation info
      -- print("Creating task for:", relative_path)

      -- Add a parameter for extra input (args) to be prompted when the task runs
      table.insert(ret, {
        name = relative_path, -- Use the relative path as the task name
        params = {
          args = {
            type = "list",
            delimiter = " ",
            prompt = "Provide additional arguments (space-separated): ",
            default = {}, -- Set to an empty list by default
          },
        },
        builder = function(params)
          -- Fix the file path issue: join the base directory with the relative path
          local full_path = files.join(base_dir, relative_path)
          return {
            cmd = { full_path }, -- Ensure the full path is passed to the command
            args = params.args, -- The args that the user enters will be passed here
          }
        end,
      })
    end

    -- Return the tasks to Overseer
    cb(ret)
  end,
}
