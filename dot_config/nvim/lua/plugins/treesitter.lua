return {
  {
    -- Syntax highlighting and code parsing using tree-sitter
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    init = function()
      -- godoc custom parser for :GoDoc syntax highlighting (used by godoc.nvim)
      -- Manual install required on each machine (requires tree-sitter CLI):
      --   cd /tmp
      --   git clone --depth 1 https://github.com/fredrikaverpil/tree-sitter-godoc.git
      --   cd tree-sitter-godoc
      --   tree-sitter build -o parser.so
      --   cp parser.so ~/.local/share/nvim/site/parser/godoc.so
      --   rm -rf /tmp/tree-sitter-godoc
      require("nvim-treesitter.parsers").godoc = {
        install_info = {
          url = "https://github.com/fredrikaverpil/tree-sitter-godoc",
          revision = "d12a20fe9f9b4e9c604937d3e66193c33587b4fd",
        },
        filetype = "godoc",
      }
      vim.treesitter.language.register("godoc", "godoc")

      -- Bruno API client (.bru files)
      -- Manual install required on each machine (requires tree-sitter CLI):
      --   cd /tmp
      --   git clone --depth 1 https://github.com/Scalamando/tree-sitter-bruno.git
      --   cd tree-sitter-bruno
      --   tree-sitter build -o parser.so
      --   cp parser.so ~/.local/share/nvim/site/parser/bruno.so
      --   rm -rf /tmp/tree-sitter-bruno
      vim.filetype.add({ extension = { bru = "bruno" } })
      vim.treesitter.language.register("bruno", "bruno")

      local ensure_installed = {
        "c",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        -- NOTE: the above are natively installed since neovim 0.12
        "bash",
        "diff",
        "dockerfile",
        "gitignore",
        "git_config",
        "luadoc",
        "regex",
        "toml",
        "yaml",
        "csv",
        "java",
        "go",
        "python",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "json",
        "vue",
        "http",
      }

      local isnt_installed = function(lang)
        return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
      end
      local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Ensure tree-sitter enabled after opening a file for target language
      local filetypes = {}
      for _, lang in ipairs(ensure_installed) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
          table.insert(filetypes, ft)
        end
      end
      table.insert(filetypes, "godoc")
      table.insert(filetypes, "bruno")
      local ts_start = function(ev)
        local ok, err = pcall(vim.treesitter.start, ev.buf)
        if not ok and not err:match("Parser could not be created") then
          vim.notify(err, vim.log.levels.WARN)
        end
      end

      -- WARN: Do not use "*" here - snacks.nvim is buggy and vim.notify triggers FileType events internally causing infinite callback loops
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Start treesitter",
        group = vim.api.nvim_create_augroup("start_treesitter", { clear = true }),
        pattern = filetypes,
        callback = ts_start,
      })
    end,
    config = function()
      require("nvim-treesitter").setup()
    end,
  },
}
