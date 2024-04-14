return {
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
        },
        bashls = {},
        ansiblels = {},
        asm_lsp = {},
        typst_lsp = {
          settings = {
            experimentalFormatterMode = "on",
            exportPdf = "onSave",
          },
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
        },
        sqlls = {},
        lemminx = {},
        opencl_ls = {},
        yamlls = {},
        lua_ls = {
          settings = {
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
      },
    },
  },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   opts = {
  --     default_settings = {
  --       -- rust-analyzer language server configuration
  --       ["rust-analyzer"] = {
  --         cargo = {
  --           allFeatures = true,
  --           loadOutDirsFromCheck = true,
  --           runBuildScripts = true,
  --         },
  --         -- Add clippy lints for Rust.
  --         checkOnSave = {
  --           allFeatures = true,
  --           command = "cargo-clippy",
  --           extraArgs = { "--no-deps" },
  --         },
  --         procMacro = {
  --           enable = true,
  --           ignored = {
  --             ["async-trait"] = { "async_trait" },
  --             ["napi-derive"] = { "napi" },
  --             ["async-recursion"] = { "async_recursion" },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
