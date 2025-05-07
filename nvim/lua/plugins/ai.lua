-- avante.nvim recommended
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

local render_md_ft = { "markdown", "Avante", "codecompanion", "mcphub" }
local pure_prompt = [[你是一个无所不能的天才. 你的人设如下,
Language: Chinese
Tone: concise,unfriendly,like mocking others
Format: markdown]]

-- gpt-3.5-turbo gpt-4o-mini gpt-4 gpt-4o o1 o3-mini o3-mini-paygo
-- claude-3.5-sonnet claude-3.7-sonnet claude-3.7-sonnet-thought
-- gemini-2.5-pro o4-mini gpt-4.1
local copilot_model = "gpt-4o"

---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      provider = "copilot",           -- 指定 Copilot 作为主要提供者
      auto_suggestions_provider = "copilot", -- 可选：用于自动建议的提供者
      copilot = {
        endpoint = "https://api.githubcopilot.com", -- Copilot API 端点
        model = "gpt-4o",        -- 默认模型，可根据需要调整
        timeout = 30000,                    -- 请求超时（毫秒）
        temperature = 0,                    -- 控制生成内容的随机性
        max_tokens = 4096, 
      },
      behaviour = {
        enable_claude_text_editor_tool_mode = true,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = render_md_ft,
        },
        ft = render_md_ft,
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-p>",
            accept_line = "<M-o>",
            accept_word = "<M-w>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          gitcommit = true,
          gitrebase = true,
          ["dap-repl"] = false,
          ["grug-far"] = false,
          ["grug-far-history"] = false,
          ["grug-far-help"] = false,
        },
        copilot_model = "gpt-4o-copilot",
      }
      -- set highlight group for copilot
      local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { italic = true, fg = comment_hl.fg })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    config = function()
      require("codecompanion").setup {
        opts = {
          language = "中文",
          -- system_prompt = function(opts)
          --   return codecompanion_system_prompt
          -- end,
        },
        prompt_library = {
          ["Pure Prompt"] = {
            strategy = "chat",
            description = "天才",
            opts = {
              ignore_system_prompt = true,
            },
            prompts = {
              {
                role = "system",
                content = pure_prompt,
              },
              {
                role = "user",
                content = "",
              },
            },
          },
        },
        strategies = {
          chat = {
            adapter = "copilot",
            roles = {
              llm = function(adapter)
                return "  天才 (" .. adapter.formatted_name .. ")"
              end,
              user = "  Me",
            },
            tools = {
              mcp = {
                -- calling it in a function would prevent mcphub from being loaded before it's needed
                callback = function()
                  return require "mcphub.extensions.codecompanion"
                end,
                description = "Call tools and resources from the MCP Servers",
              },
            },
          },
          inline = { adapter = "copilot" },
          cmd = { adapter = "copilot" },
        },
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = { model = { default = copilot_model } },
            })
          end,
        },
      }
    end,
    keys = {
      { "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "CodeCompanionChat" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
    },
    init = function()
      require("configs.codecompanion").init()
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    event = "VeryLazy",
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup {
        use_bundled_binary = true, -- Set to true if you want to use the bundled mcp-hub binary
        auto_approve = true,
        extensions = {
          codecompanion = {
            -- Show the mcp tool result in the chat buffer
            show_result_in_chat = true,
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
          },
        },
      }
    end,
  },
}
