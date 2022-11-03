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
	  "eslint", -- latex
		"clangd", -- cpp / c
		--"tsserver", -- python
		"texlab", -- latex
		"sumneko_lua", -- lua
		"pyright", -- python
		"rust_analyzer", -- rust
		"jdtls", -- jdtls
		"cmake", -- cmake
		"bashls", -- shell
		"ansiblels", -- ansible
		"csharp_ls", -- dotnot
		"hls", -- haskel
	},
	automatic_installation = true,
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig")["cssls"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["html"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["eslint"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["clangd"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

--require("lspconfig")["tsserver"].setup({
--	capabilities = capabilities,
	--on_attach = on_attach,
--})

require("lspconfig")["texlab"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["sumneko_lua"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["pyright"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["rust_analyzer"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["jdtls"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["cmake"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["bashls"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["ansiblels"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["csharp_ls"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

require("lspconfig")["hls"].setup({
	capabilities = capabilities,
	--on_attach = on_attach,
})

