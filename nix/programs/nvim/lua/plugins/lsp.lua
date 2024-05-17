return {
	{
		"williamboman/mason.nvim",
		--opts = function()
		--	return {
		--		ensure_installed = {},
		--	}
		--end,
	},
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			-- inlay_hints = {
			--   enabled = true,
			-- },
			format_notify = false,
			-- LSP Server Settings
			---@type lspconfig.options
			servers = {
				rust_analyzer = {
					mason = false,
				},
				marksman = {
					mason = false,
				},
				clangd = {
					mason = false,
				},
				jdtls = {
					mason = false,
				},
				gopls = {
					mason = false,
				},
				pyright = {
					mason = false,
				},
				ruff_lsp = {
					mason = false,
				},
				texlab = {
					mason = false,
				},
				taplo = {
					keys = {
						{
							"K",
							function()
								if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
									require("crates").show_popup()
								else
									vim.lsp.buf.hover()
								end
							end,
							desc = "Show Crate Documentation",
						},
					},
					mason = false,
				},
				bashls = {
					mason = false,
				},
				ansiblels = {
					mason = false,
				},
				omnisharp = {
					mason = false,
					cmd = { "OmniSharp" },
				},
				typst_lsp = {
					settings = {
						experimentalFormatterMode = "on",
						exportPdf = "onSave",
					},
					mason = false,
				},
				nil_ls = {
					settings = {
						["nil"] = {
							formatting = {
								command = { "nixpkgs-fmt" },
							},
						},
					},
					mason = false,
				},
				ltex = {
					settings = {
						ltex = {
							checkFrequency = "save",
						},
					},
					filetypes = {
						"bib",
						"gitcommit",
						"markdown",
						"org",
						"plaintex",
						"rst",
						"rnoweb",
						"tex",
						"pandoc",
						"typst",
						"typ",
					},
					mason = false,
				},
				sqlls = {
					mason = false,
				},
				lemminx = {
					mason = false,
				},
				opencl_ls = {
					mason = false,
				},
				yamlls = {
					mason = false,
				},
				cssls = {
					mason = false,
					cmd = { "css-languageserver", '--stdio' },
				},
				lua_ls = {
					mason = false,
					{
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			},
		},
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			local my_keys = require("config.lsp-keymap").get()
			local count = 0
			for _ in pairs(my_keys) do
				keys[#keys + 1] = my_keys[count]
				count = count + 1
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			keys = {
				{
					-- Customize or remove this keymap to your liking
					"<leader>cF",
					function()
						require("conform").format({ async = true, lsp_fallback = true })
					end,
					mode = "",
					desc = "Format buffer",
				},
			},
			formatters_by_ft = {
				typst = { "typstfmt" },
				nix = { "nixpkgs-fmt" },
				lua = { "stylua" },
				sh = { "shfmt" },
				cs = { "dotnet-csharpier" },
			},
		},
	},
}
