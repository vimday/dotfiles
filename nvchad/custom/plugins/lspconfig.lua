local _on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
  _on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

require("lspconfig").clangd.setup {
  on_attach = on_attach
}
local lspconfig = require "lspconfig"

local servers = { "vimls", "html", "cssls", "bashls", "pyright", "gopls", "tsserver", "jsonls", "taplo", "prosemd_lsp",
  "eslint" }

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
