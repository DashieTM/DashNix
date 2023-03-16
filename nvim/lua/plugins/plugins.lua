return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    opts = {
      autochdir = true,
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, _)
      require("nvim-highlight-colors").setup({
        enable_tailwind = true,
      })
      vim.cmd(":hi clear CursorLine")
      vim.cmd(":hi clear CursorLineFold")
      vim.cmd(":hi clear CursorLineSign")
    end,
  },
  {
    "gpanders/editorconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
  },
  {
    "ThePrimeagen/harpoon",
    lazy = true,
    config = function()
      require("telescope").load_extension("harpoon")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    event = "FileType markdown",
    build = "cd app && yarn install",
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
      -- require("vimtex").setup()
      vim.cmd("let g:vimtex_quickfix_mode=0")
      vim.cmd("let g:vimtex_view_general_viewer = 'evince'")
      vim.cmd("let g:vimtex_compiler_method = 'latexmk'")
      vim.cmd(
        "let g:vimtex_compiler_latexmk = {'options': ['-pdf', '-shell-escape', '-file-line-error', '--extra-mem-bot=10000000', '-synctex=1', '-interaction=nonstopmode',],}"
      )
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        group_empty_dirs = true,
      },
      window = {
        mappings = {
          ["f"] = "close_window",
        },
        position = "right",
        scan_mode = "deep",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    enabled = false,
  },
  {
  "rcarriga/nvim-notify",
    opts = {
      top_down = false,
    },
  },
}
