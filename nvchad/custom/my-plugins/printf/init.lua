local M = {}

local printf_mark = "__AUTO_GEN_BY_PRINTF_NVIM__"

local cmt_mark = {
  lua = "--",
  python = "#",
  default = "//",
}

M.printf = function()
  M._printf(vim.fn.expand "<cexpr>")
end

M._printf = function(expr)
  local ft = vim.o.filetype
  local temp = M.config[ft]

  if temp ~= nil then
    temp = string.format("%s %s %s", temp, (cmt_mark[ft] or cmt_mark.default), printf_mark)
    temp = string.gsub(temp, "%$%$", expr)
    vim.fn.setline(".", temp)
  end
end

M.clear = function ()
  vim.cmd(string.format("/%s/d", printf_mark))
end

local js_temp = 'console.log(">>> $$:", $$)'

M.config = {
  go = 'fmt.Printf(">>> $$: %+v\n", $$)',
  lua = 'print(">>> $$:", $$)',
  typescript = js_temp,
  javascript = js_temp,
  typescriptreact = js_temp,
  javascriptreact = js_temp,
}

return M
