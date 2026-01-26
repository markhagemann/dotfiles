-- Use vim.fs.joinpath instead of files.join for v2
local function joinpath(...)
  return vim.fs.joinpath(...)
end

-- Function to recursively find 'bin', 'scripts', or 'tools' directories and return their files
local function find_shell_script_files(base_dir)
  local dirs = { "bin", "scripts", "tools" }
  local excluded_dirs = { ".git", "node_modules", "ci" }
  local all_files = {}

  local function recursive_find(dir)
    local file_list = vim.fn.readdir(dir)
    for _, file in ipairs(file_list) do
      local full_path = joinpath(dir, file)
      local skip = false

      for _, excluded in ipairs(excluded_dirs) do
        if file == excluded then
          skip = true
          break
        end
      end

      if skip then
        goto continue
      end

      local is_valid_dir = false
      for _, target_dir in ipairs(dirs) do
        if string.find(full_path, target_dir) then
          is_valid_dir = true
          break
        end
      end

      if vim.fn.isdirectory(full_path) == 1 then
        if is_valid_dir then
          local files_in_dir = vim.fn.readdir(full_path)
          for _, f in ipairs(files_in_dir) do
            local file_path = joinpath(full_path, f)
            if vim.fn.filereadable(file_path) == 1 then
              table.insert(all_files, file_path)
            end
          end
        end
        recursive_find(full_path)
      end
      ::continue::
    end
  end

  recursive_find(base_dir)
  return all_files
end

return {
  generator = function(opts, cb)
    local base_dir = vim.fn.getcwd()
    local all_files = find_shell_script_files(base_dir)

    local scripts = vim.tbl_filter(function(filename)
      return filename:match("%.sh$") or filename:match("^[^.]+$")
    end, all_files)

    local ret = {}
    for _, filename in ipairs(scripts) do
      local relative_path = filename:sub(#base_dir + 2)
      table.insert(ret, {
        name = relative_path,
        params = {
          args = {
            type = "list",
            delimiter = " ",
            desc = "Additional arguments (space-separated)", -- This is the key!
            optional = false,
          },
        },
        builder = function(params)
          local full_path = joinpath(base_dir, relative_path)
          return {
            cmd = { full_path },
            args = params.args or {},
          }
        end,
      })
    end
    cb(ret)
  end,
}
