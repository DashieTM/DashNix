return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "akinsho/toggleterm.nvim",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function(_, _)
      require("nvim-highlight-colors").setup()
      vim.cmd(":hi clear CursorLine")
      vim.cmd(":hi clear CursorLineFold")
      vim.cmd(":hi clear CursorLineSign")
    end,
  },
  {
    "gpanders/editorconfig.nvim",
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("telescope").load_extension("harpoon")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
  },
  {
    "nvim-telescope/telescope-project.nvim",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "jvgrootveld/telescope-zoxide",
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
}
