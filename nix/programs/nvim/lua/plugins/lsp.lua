return {
	{
		"williamboman/mason.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = function(_, opts)
			local path = vim.fn.stdpath("config") .. "/spell/ltex.dictionary.en-US.txt"
			local words = {}

			local file, err = io.open(path, "r")
			if err ~= nil then
				os.execute("mkdir " .. vim.fn.stdpath("config") .. "/spell")
				file = io.open(path, "w")
				file:write("")
				file:close()
				file = io.open(path, "r")
			end
			for word in file:lines() do
				table.insert(words, word)
			end
			local new_opts = {
				format_notify = false,
				-- LSP Server Settings
				---@type lspconfig.options
				servers = {
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
						handlers = {
							["textDocument/definition"] = function(...)
								return require("omnisharp_extended").handler(...)
							end,
						},
						keys = {
							{
								"<leader>oe",
								function()
									require("omnisharp_extended").telescope_lsp_definitions()
								end,
								desc = "Goto Definition",
							},
						},
						cmd = {
							-- no comment
							"OmniSharp",
							"-z",
							"--hostPID",
							tostring(vim.fn.getpid()),
							"DotNet:enablePackageRestore=false",
							"--encoding",
							"utf-8",
							"--languageserver",
							"FormattingOptions:EnableEditorConfigSupport=true",
							"FormattingOptions:OrganizeImports=true",
							"RoslynExtensionsOptions:EnableAnalyzersSupport=true",
							"RoslynExtensionsOptions:EnableImportCompletion=true",
							-- inlay hints are bugged until next release.....
							-- "RoslynExtensionsOptions:InlayHintsOptions:EnableForParameters=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForLiteralParameters=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForIndexerParameters=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForObjectCreationParameters=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForOtherParameters=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:SuppressForParametersThatDifferOnlyBySuffix=false",
							-- "RoslynExtensionsOptions:InlayHintsOptions:SuppressForParametersThatMatchMethodIntent=false",
							-- "RoslynExtensionsOptions:InlayHintsOptions:SuppressForParametersThatMatchArgumentName=false",
							-- "RoslynExtensionsOptions:InlayHintsOptions:EnableForTypes=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForImplicitVariableTypes=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForLambdaParameterTypes=true",
							-- "RoslynExtensionsOptions:InlayHintsOptions:ForImplicitObjectCreation=true",
							"Sdk:IncludePrereleases=true",
						},
					},
					tinymist = {
						settings = {
							formatterMode = "typstyle",
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
								dictionary = {
									["en-US"] = words,
								},
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
							"text",
						},
						mason = false,
					},
					sqls = {
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
					zls = {
						mason = false,
					},
					jsonls = {
						mason = false,
						cmd = { "vscode-json-languageserver", "--stdio" },
					},
					cssls = {
						mason = false,
						cmd = { "css-languageserver", "--stdio" },
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
			}
			return vim.tbl_deep_extend("keep", new_opts, opts)
		end,
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
					"<leader>cF",
					function()
						require("conform").format({ async = true, lsp_fallback = true })
					end,
					mode = "",
					numberdesc = "Format buffer",
				},
			},
			formatters = {
				mdformat = {
					prepend_args = { "--number" },
				},
			},
			formatters_by_ft = {
				nix = { "nixpkgs-fmt" },
				lua = { "stylua" },
				sh = { "shfmt" },
				cs = { "dotnet-csharpier" },
				markdown = { "mdformat" },
				sql = { "sql-formatter" },
				json = { "jq" },
				yaml = { "yamlfmt" },
			},
		},
	},
}
