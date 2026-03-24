local default_picker_opts = {
  opts = {
    provider = "snacks",
  },
}

-- Get the mise global node bin path dynamically
local function get_mise_global_node_bin()
  local version = vim.fn.system("mise global node 2>/dev/null"):gsub("%s+", "")
  if version and version ~= "" then
    return vim.fn.expand("~/.local/share/mise/installs/node/" .. version .. "/bin")
  end
  return nil
end

local http_adapter = (vim.env.ENABLE_COPILOT == "true" and "copilot")
  or (vim.env.OPENROUTER_API_KEY and "openrouter")
  or nil

local default_adapter = (vim.env.CODECOMPANION_AGENT == "claude_code" and "claude_code") or http_adapter

return {
  -- AI coding assistant with chat and inline editing capabilities via OpenRouter
  "olimorris/codecompanion.nvim",
  version = "^19",
  enabled = vim.env.ENABLE_CODECOMPANION == "true",
  config = function()
    -- Inline extmarks: show sign column indicators during inline edits
    local inline_extmark_opts = {
      sign_hl_group = "DiagnosticVirtualTextWarn",
      sign_text = "│",
      priority = 2048,
    }

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequest*",
      callback = function(args)
        local data = args.data or {}
        local context = data.buffer_context or {}

        if vim.tbl_isempty(context) and data.interaction ~= "inline" then
          return
        end

        local ns_id = vim.api.nvim_create_namespace("CodeCompanionInline_" .. data.id)

        if args.match:find("Started") then
          if context.start_line == context.end_line then
            vim.api.nvim_buf_set_extmark(
              context.bufnr,
              ns_id,
              context.start_line - 1,
              0,
              vim.tbl_extend("force", inline_extmark_opts, { sign_text = "" })
            )
          else
            vim.api.nvim_buf_set_extmark(
              context.bufnr,
              ns_id,
              context.start_line - 1,
              0,
              vim.tbl_extend("force", inline_extmark_opts, { sign_text = "┌" })
            )
            for i = context.start_line + 1, context.end_line - 1 do
              vim.api.nvim_buf_set_extmark(context.bufnr, ns_id, i - 1, 0, inline_extmark_opts)
            end
            if context.end_line > context.start_line then
              vim.api.nvim_buf_set_extmark(
                context.bufnr,
                ns_id,
                context.end_line - 1,
                0,
                vim.tbl_extend("force", inline_extmark_opts, { sign_text = "└" })
              )
            end
          end
        elseif args.match:find("Finished") then
          vim.api.nvim_buf_clear_namespace(context.bufnr, ns_id, 0, -1)
        end
      end,
    })

    require("codecompanion").setup({
      adapters = {
        acp = vim.env.CODECOMPANION_AGENT == "claude_code" and {
          claude_code = function()
            local mise_bin = get_mise_global_node_bin()
            local cmd = mise_bin and (mise_bin .. "/claude-agent-acp") or "claude-agent-acp"
            return require("codecompanion.adapters.acp").extend("claude_code", {
              commands = {
                default = { cmd },
              },
              defaults = {
                mcpServers = "inherit_from_config",
              },
            })
          end,
        } or nil,
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },
          copilot = vim.env.ENABLE_COPILOT == "true" and "copilot" or nil,
          openrouter = vim.env.OPENROUTER_API_KEY and function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
                models_endpoint = "/models",
              },
              schema = {
                model = {
                  default = "mistralai/devstral-2512:free",
                },
              },
            })
          end or nil,
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
      },
      interactions = {
        chat = {
          adapter = default_adapter,
          icons = {
            chat_context = "📎️",
          },
          slash_commands = {
            -- Files / buffers
            file = default_picker_opts,
            buffer = default_picker_opts,
            buffers = default_picker_opts,

            -- Project / filesystem
            files = default_picker_opts,
            cwd = default_picker_opts,

            -- Git
            git_file = default_picker_opts,
            git_files = default_picker_opts,
            git_diff = default_picker_opts,
            git_commit = default_picker_opts,

            -- Diagnostics / symbols
            diagnostic = default_picker_opts,
            symbols = default_picker_opts,

            -- Misc
            help = default_picker_opts,
            recent = default_picker_opts,
            time = default_picker_opts,
            date = default_picker_opts,
          },
          fold_context = true,
          fold_reasoning = true,
          show_reasoning = true,
          tools = {
            ["cmd_runner"] = {
              opts = {
                require_approval_before = true,
              },
            },
          },
        },
        inline = http_adapter and {
          adapter = http_adapter,
        } or nil,
        background = {
          adapter = default_adapter,
          chat = {
            opts = {
              enabled = default_adapter ~= nil,
            },
          },
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            auto_generate_title = (vim.env.ENABLE_COPILOT == "true" or vim.env.OPENROUTER_API_KEY) and true or false,
            title_generation_opts = (vim.env.ENABLE_COPILOT == "true" or vim.env.OPENROUTER_API_KEY) and {
              adapter = vim.env.ENABLE_COPILOT == "true" and "copilot" or "openrouter",
            } or nil,
          },
        },
      },
    })
  end,
  keys = vim.tbl_filter(function(k)
    return k ~= nil
  end, {
    http_adapter and { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI: actions", mode = { "n", "v" } }
      or nil,
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: chat" },
    http_adapter and { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "AI: inline", mode = { "n", "v" } } or nil,
    { "<leader>ah", "<cmd>CodeCompanionHistory<cr>", desc = "AI: history" },
    { "<leader>a+", "<cmd>CodeCompanionChat Add<cr>", desc = "AI: add to chat", mode = { "v" } },
  }),
  dependencies = {
    -- Utility library for Neovim plugins (async, file operations, etc.)
    "nvim-lua/plenary.nvim",
    -- Tree-sitter integration for code parsing
    "nvim-treesitter/nvim-treesitter",
    -- Chat history management for CodeCompanion
    "ravitemer/codecompanion-history.nvim",
    {
      -- Progress notifications for CodeCompanion requests via fidget.nvim
      "j-hui/fidget.nvim",
      opts = {},
      config = function(_, opts)
        require("fidget").setup(opts)

        local progress = require("fidget.progress")
        local handles = {}

        local function llm_role_title(adapter)
          local parts = { adapter.formatted_name }
          if adapter.model and adapter.model ~= "" then
            table.insert(parts, "(" .. adapter.model .. ")")
          end
          return table.concat(parts, " ")
        end

        local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

        vim.api.nvim_create_autocmd("User", {
          pattern = "CodeCompanionRequestStarted",
          group = group,
          callback = function(request)
            handles[request.data.id] = progress.handle.create({
              title = " Requesting assistance ("
                .. (request.data.strategy or request.data.interaction or "unknown")
                .. ")",
              message = "In progress...",
              lsp_client = { name = llm_role_title(request.data.adapter) },
            })
          end,
        })

        vim.api.nvim_create_autocmd("User", {
          pattern = "CodeCompanionRequestFinished",
          group = group,
          callback = function(request)
            local handle = handles[request.data.id]
            handles[request.data.id] = nil
            if handle then
              if request.data.status == "success" then
                handle.message = "Completed"
              elseif request.data.status == "error" then
                handle.message = "Error"
              else
                handle.message = "Cancelled"
              end
              handle:finish()
            end
          end,
        })
      end,
    },
    {
      -- Support for image pasting in markdown and chat buffers
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          dir_path = vim.fn.expand("~/Pictures/Screenshots"),
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
