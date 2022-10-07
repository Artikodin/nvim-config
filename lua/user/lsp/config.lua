local isMasonConfigDefined, mason_config = pcall(require, "mason-lspconfig")
if not isMasonConfigDefined then
  return
end

mason_config.setup({
  ensure_installed = { "tsserver", "sumneko_lua", "jsonls" },
})

require("lspconfig").flow.setup({})

mason_config.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    })
  end,

  ["sumneko_lua"] = function()
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    require("lspconfig").sumneko_lua.setup(sumneko_opts)
  end,

  ["jsonls"] = function()
    local jsonls_opts = require("user.lsp.settings.jsonls")
    require("lspconfig").jsonls.setup(jsonls_opts)
  end,

  ["tsserver"] = function()
    require("lspconfig").tsserver.setup({
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    })
  end,
})
