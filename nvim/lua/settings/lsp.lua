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

--local status_ok2, lsp_installer = pcall(require, "mason")
--if not status_ok2 then
--	return
--end
--
--local servers = {"jdtls" , "sumneko_lua" , "texlab", "pyright" , "eslint_d" , "html" , "cssls" , "rust_analyzer" , "bashls" , "csharp_ls" , "sqls" , "clangd" }
--
--lsp_installer.setup {
--	ensure_installed = servers
--}
--
--for _, server in pairs(servers) do
--	local opts = {
--		on_attach = require("settings.lsp_config.handlers").on_attach,
--		capabilities = require("settings.lsp_config.handlers").capabilities,
--	}
--	local has_custom_opts, server_custom_opts = pcall(require, "settings.lsp_config." .. server)
--	if has_custom_opts then
--	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
--	end
--	lspconfig[server].setup(opts)
--end
--
--
--local null_ls_status_ok, null_ls = pcall(require, "null-ls")
--if not null_ls_status_ok then
--	return
--end
--
---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
--local formatting = null_ls.builtins.formatting
---- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--local diagnostics = null_ls.builtins.diagnostics
--
--null_ls.setup({
--	debug = false,
--	sources = {
--		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
--		formatting.black.with({ extra_args = { "--fast" } }),
--		formatting.stylua,
--    -- diagnostics.flake8
--	},
--})
