local null_ls = require("null-ls")

require("mason-null-ls").setup({
	ensure_installed = {
		"prettierd",
		"clang_format",
		"shellharden",
		"sql_formatter",
		"fixjson",
		"autopep8",
		"stylua",
		"rustfmt",
	},
})

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentRangeFormattingProvider then
			vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
		end
	end,
	sources = {
		require("null-ls").builtins.formatting.prettierd.with({
      env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/lua/settings/.prettierrc"),
      },}
    ),
		require("null-ls").builtins.formatting.clang_format,
		require("null-ls").builtins.formatting.shellharden,
		require("null-ls").builtins.formatting.sql_formatter,
		require("null-ls").builtins.formatting.fixjson,
		require("null-ls").builtins.formatting.autopep8,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.rustfmt,
	},
})
