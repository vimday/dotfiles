local statusline_overrides = function()
  local st_modules = require "nvchad_ui.statusline.modules"

  local function nvim_navic()
    local navic = require "nvim-navic"

    if navic.is_available() then
      return navic.get_location()
    else
      return " "
    end
  end

  -- override lsp_progress statusline module
  return {
    LSP_progress = function()
      if rawget(vim, "lsp") then
        -- return st_modules.LSP_progress() .. "%#Nvim_navic#" .. nvim_navic()
        return st_modules.LSP_progress() .. nvim_navic()
      else
        return ""
      end
    end,
  }
end

return {
  statusline = {
    overriden_modules = function()
      return statusline_overrides()
    end,
  },
}
