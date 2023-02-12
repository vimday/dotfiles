local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "vimls",
  "html",
  "cssls",
  "bashls",
  "pyright",
  "gopls",
  "tsserver",
  "jsonls",
  "yamlls",
  "taplo",
  "prosemd_lsp",
  "eslint",
  "clangd"
}

for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    -- fix bug
    local capabilities4clangd = vim.deepcopy(capabilities)
    capabilities4clangd.offsetEncoding = { "utf-16" }
    lspconfig.clangd.setup { capabilities = capabilities4clangd, on_attach = on_attach }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end
