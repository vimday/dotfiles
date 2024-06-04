local M = {}

M.ui = {
  theme = "chadracula",
  hl_override = {
    DiffAdd = { fg = "green", bg = '#123b1a' },
    DiffDelete = { fg = "red" },
    DiffChange = { fg = "orange" },
    WildMenu = { fg = "#6ad8eD", bg = "#30385f" },
    IncSearch = { bg = "#e0af68", fg = "#373640" },
    ["@keyword"] = { italic = true },
    ["@keyword.function"] = { italic = true },
    ["@keyword.return"] = { italic = true },
  },
  -- lazyload it when there are 1+ buffers
  tabufline = {
    lazyload = false,
  },
}

return M
