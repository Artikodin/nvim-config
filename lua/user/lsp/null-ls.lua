local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

require("mason-null-ls").setup({
  ensure_installed = { "stylua", "prettier", "eslint_d" }
})

require 'mason-null-ls'.setup_handlers {
  stylua = function()
    null_ls.register(formatting.stylua)
  end,
  prettier = function()
    null_ls.register(formatting.prettier)
  end,
  eslint_d = function()
    null_ls.register(diagnostics.eslint_d)
  end
}

-- run following command:
-- brew install eslint
-- brew install prettier
-- brew install stylua

null_ls.setup()
