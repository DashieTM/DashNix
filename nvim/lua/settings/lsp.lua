local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls", -- css
    "html", -- html
    "clangd", -- cpp / c
    "sumneko_lua", -- lua
    "pyright", -- python
    "cmake", -- cmake
    "bashls", -- shell
    "ansiblels", -- ansible
    "marksman", -- markdown
    "asm_lsp", -- assembly
    "tsserver", -- js and ts
    "ltex", -- latex
    "jdtls" -- jafuck
  },
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP
-- require("lsp-format").setup {}
require("lsp-inlayhints").setup()
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local optslsp = { noremap = false, silent = true, buffer = bufnr }
  -- require("lsp-format").on_attach(client)
  require("lsp-inlayhints").on_attach(client, bufnr)
end

require("rust-tools").setup({
  server = {
    standalone = false,
    root_dir = require('lspconfig').util.find_git_ancestor,
    loadOutputiDirs = false,
  }
})

require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = true,
      }

    })
  end,
  ['tsserver'] = function()
    require('lspconfig').tsserver.setup {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      },
      capabilities = capabilities,
      on_attach = on_attach,
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
      }
    }
  end,
})


-- special server setups
require("clangd_extensions").setup(
-- brudi no troll plox
)
