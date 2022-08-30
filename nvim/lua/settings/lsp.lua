local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end


require'lspconfig'.hls.setup {}
require'lspconfig'.pyright.setup {}
require'lspconfig'.clangd.setup {}
require'lspconfig'.html.setup {}
require'lspconfig'.eslint.setup {}
require'lspconfig'.texlab.setup {}
require'lspconfig'.jdtls.setup {}
require'lspconfig'.sumneko_lua.setup {}
require'lspconfig'.gopls.setup {}
require'lspconfig'.jsonls.setup {}


require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})


local status_ok2, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok2 then
	return
end

local lspconfig = require("lspconfig")
local servers = {"jdtls" , "sumneko_lua" , "texlab", "pyright" , "eslint" , "html" }

lsp_installer.setup {
	ensure_installed = servers
}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("settings.lsp_config.handlers").on_attach,
		capabilities = require("settings.lsp_config.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "settings.lsp_config." .. server)
	if has_custom_opts then
	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end


local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
    -- diagnostics.flake8
	},
})
