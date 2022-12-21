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
		"tsserver", -- python
		"texlab", -- latex
		"sumneko_lua", -- lua
		"pyright", -- python
		"rust_analyzer", -- rust
		"jdtls", -- jdtls
		"cmake", -- cmake
		"bashls", -- shell
		"ansiblels", -- ansible
		"omnisharp", -- dotnot
		"hls", -- haskel
	},
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true, buffer=bufnr }
	vim.keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.keymap.set("n", "<M-CR>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
})
