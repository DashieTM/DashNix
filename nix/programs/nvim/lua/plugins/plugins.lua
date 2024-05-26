local Util = require("lazyvim.util")

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight-night",
			-- colorscheme = "catppuccin-mocha",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = function()
			return {}
		end,
		opts = {
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					flex = {
						height = 0.95,
						width = 0.95,
						flip_columns = 100,
					},
					vertical = { preview_height = 0.5, preview_cutoff = 5 },
					horizontal = { preview_width = 0.7, preview_cutoff = 99 },
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-project.nvim",
		lazy = true,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		lazy = true,
		config = function()
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		lazy = true,
		config = function()
			local z_utils = require("telescope._extensions.zoxide.utils")
			local t = require("telescope")
			-- Configure the extension
			t.setup({
				extensions = {
					zoxide = {
						prompt_title = "[ Queries ]",
						mappings = {
							default = {
								after_action = function(selection)
									print("Update to (" .. selection.z_score .. ") " .. selection.path)
								end,
							},
							["<C-s>"] = {
								before_action = function(selection)
									print("before C-s")
								end,
								action = function(selection)
									vim.cmd("edit " .. selection.path)
								end,
							},
							["<C-q>"] = { action = z_utils.create_basic_command("split") },
						},
					},
				},
			})

			-- Load the extension
			t.load_extension("zoxide")
		end,
	},
	{
		"lervag/vimtex",
		config = function()
			vim.cmd("let g:vimtex_quickfix_mode=0")
			vim.cmd("let g:vimtex_view_general_viewer = 'evince'")
			vim.cmd("let g:vimtex_compiler_method = 'latexmk'")
			vim.cmd(
				"let g:vimtex_compiler_latexmk = {'options': ['-pdf', '-shell-escape', '-file-line-error', '--extra-mem-bot=10000000', '-synctex=1', '-interaction=nonstopmode',],}"
			)
		end,
	},
	{
		"jbyuki/instant.nvim",
		config = function()
			vim.cmd("let g:instant_username = 'dashie'")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		},
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"kaarmu/typst.vim",
		lazy = true,
		event = "FileType typst",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
				["<leader>h"] = { name = "+harpoon" },
				["<leader>d"] = { name = "+DAP" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"f-person/git-blame.nvim",
		lazy = true,
	},
	{
		"mg979/vim-visual-multi",
	},
	{
		"barreiroleo/ltex_extra.nvim",
		ft = { "markdown", "tex", "typst", "typ" },
		lazy = true,
	},
	{
		"smjonas/inc-rename.nvim",
		lazy = true,
		event = "BufEnter",
		config = function()
			require("inc_rename").setup({
				cmd_name = "IncRename", -- the name of the command
				hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
				preview_empty_name = true, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
				show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
				input_buffer_type = nil, -- the type of the external input buffer to use (the only supported value is currently "dressing")
				post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				renderer = {
					group_empty = true,
				},
				view = {
					side = "right",
				},
				diagnostics = {
					enable = true,
				},
			})
		end,
		keys = {
			{
				"<leader>fe",
				function()
					require("nvim-tree.api").tree.toggle()
				end,
				desc = "Explorer NvimTree (root dir)",
			},
			{
				"<leader>fE",
				function()
					require("nvim-tree.api").tree.toggle()
				end,
				desc = "Explorer NvimTree (cwd)",
			},
			{ "<A-f>", "<leader>fe", desc = "Explorer NvimTree (root dir)", remap = true },
			{ "<A-F>", "<leader>fE", desc = "Explorer NvimTree (cwd)", remap = true },
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{
				"<leader>dk",
				function()
					require("dap").down()
				end,
				desc = "Down",
			},
			{
				"<leader>dl",
				function()
					require("dap").up()
				end,
				desc = "Up",
			},
			{
				"<leader>d;",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"rcasia/neotest-java",
		},
		opts = {
			adapters = {
				["neotest-java"] = {
					ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
					junit_jar = "/home/dashie/.local/share/nvim/mason/bin/junit-standalone.jar",
					-- default: .local/share/nvim/neotest-java/junit-platform-console-standalone-[version].jar
				},
			},
		},
	},
	{
		"DashieTM/test_plugin",
		lazy = false,
		opts = {
			what = 0,
		},
	},
	{
		"DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>fy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
		},
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Toggle Difftool" },
		},
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{ "Hoffs/omnisharp-extended-lsp.nvim" },
	{
		"barreiroleo/ltex_extra.nvim",
		branch = "dev",
		ft = { "tex", "typst", "text" },
		-- this causes an error with fsharp since
		-- they use markdown to show lsp messages
		config = function()
			require("ltex_extra").setup({
				load_langs = { "en-US" },
				path = vim.fn.stdpath("config") .. "/spell",
			})
		end,
	},
	{ "ionide/Ionide-vim", ft = "fsharp" },
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^3",
		lazy = false,
	},
}
