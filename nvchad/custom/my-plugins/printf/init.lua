local M = {}

local printf_mark = "__AUTO_GEN_BY_PRINTF_NVIM__"

local cmt_mark = {
  lua = "--",
  python = "#",
  default = "//",
  sh = "#",
}

local function escape(s)
  return s:gsub('"', '\\"')
end

M.printf = function()
  local line = vim.fn.getline "."
  M._printf(line:match "^%s*(.-)%s*$", line:match "^%s*")
end

M._printf = function(expr, indent)
  local ft = vim.o.filetype
  local temp = M.config[ft]

  if temp ~= nil then
    temp = string.format("%s%s %s %s", indent, temp, (cmt_mark[ft] or cmt_mark.default), printf_mark)
    temp = string.gsub(temp, "%$%$", expr)
    local e, _ = escape(expr)
    temp = string.gsub(temp, "%$%#", e)
    vim.fn.setline(".", temp)
  end
end

M.clear = function()
  vim.cmd(string.format("g/%s/d", printf_mark))
end

local js_temp = 'console.log(">>> $# =", $$)'

M.config = {
  go = 'fmt.Printf(">>> $# = %+v\\n", $$)',
  lua = 'print(">>> $# =", vim.inspect($$))',
  python = 'print(">>> $# =", $$)',
  typescript = js_temp,
  javascript = js_temp,
  typescriptreact = js_temp,
  javascriptreact = js_temp,
}

M.setup = function()
  vim.api.nvim_create_user_command("PrintfClear", "lua require('custom.my-plugins.printf').clear()", {})
end

return M
