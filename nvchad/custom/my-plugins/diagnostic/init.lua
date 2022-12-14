local M = {}

local severity2str = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

M.preview = function()
  local d = vim.diagnostic.get(0, { lnum = vim.fn.line "." - 1 })
  if #d == 0 then
    return
  end

  table.sort(d, function(a, b)
    return a.severity < b.severity
  end)

  local res = {}
  for _, v in ipairs(d) do
    table.insert(res, string.format("%s  %s (%s)\n", severity2str[v.severity], v.message, v.source))
  end
  print(table.concat(res, "\n"))
end

return M
