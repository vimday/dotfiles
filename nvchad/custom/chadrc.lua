-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "chadracula",
  hl_override = require "custom.highlights",
  -- theme_toggle = { "chadracula", "one_light" },
  -- nvdash = {
  --   load_on_startup = true,
  -- },
}

M.mappings = require "custom.mappings"

M.plugins = "custom.plugins"

return M
