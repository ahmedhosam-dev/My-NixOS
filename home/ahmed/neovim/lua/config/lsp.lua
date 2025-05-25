local lspconfig = require("lspconfig")

-- Enable keybindings and autocompletion
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

-- Lua
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Python
lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })

-- C/C++
lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })

-- Markdown
lspconfig.marksman.setup({ on_attach = on_attach, capabilities = capabilities })

-- Nix
lspconfig.nixd.setup({ on_attach = on_attach, capabilities = capabilities })

-- YAML
lspconfig.yamlls.setup({ on_attach = on_attach, capabilities = capabilities })

-- Vue
lspconfig.volar.setup({ on_attach = on_attach, capabilities = capabilities })

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })

-- TailwindCSS
lspconfig.tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })

-- Svelte
lspconfig.svelte.setup({ on_attach = on_attach, capabilities = capabilities })

-- Vim
lspconfig.vimls.setup({ on_attach = on_attach, capabilities = capabilities })

-- CMake
lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })

-- Java
lspconfig.jdtls.setup({ on_attach = on_attach, capabilities = capabilities })

-- Docker
lspconfig.dockerls.setup({ on_attach = on_attach, capabilities = capabilities })
