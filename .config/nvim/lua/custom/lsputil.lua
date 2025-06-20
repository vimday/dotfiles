local M = {}
M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      }
    end
  end,
})

M.hover = function()
  local opts = {
    border = "rounded",
  }
  vim.lsp.buf.hover(opts)
end

M.diagnostic_config = function()
  require("nvchad.lsp").diagnostic_config()
end

return M
