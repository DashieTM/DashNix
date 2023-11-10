return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      capabilities = {},
      autoformat = false,
      format_notify = false,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        tailwindcss = {},
        cssls = {},
        html = {},
        clangd = {
          root_pattern = {
            ".clangd",
            ".clang-tidy",
            ".clang-format",
            "compile_commands.json",
            "compile_flags.txt",
            "configure.ac",
            ".git",
            "build/compile_commands.json",
          },
          filetypes = {
            "c",
            "cpp",
            "objc",
            "objcpp",
            "cuda",
            "proto",
            "cl",
          },
        },
        pyright = {},
        cmake = {},
        bashls = {},
        ansiblels = {},
        marksman = {},
        asm_lsp = {},
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          inlayHintsOptions = {
            enableForParameters = true,
            forLiteralParameters = true,
            forIndexerParameters = true,
            forObjectCreationParameters = true,
            forOtherParameters = true,
            suppressForParametersThatDifferOnlyBySuffix = false,
            suppressForParametersThatMatchMethodIntent = false,
            suppressForParametersThatMatchArgumentName = false,
            enableForTypes = true,
            forImplicitVariableTypes = true,
            forLambdaParameterTypes = true,
            forImplicitObjectCreation = true,
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
        rnix = {},
        rust_analyzer = {
          diagnostics = {
            enable = true,
            experimental = true,
          },
        },
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        typst_lsp = {
          settings = {
            experimentalFormatterMode = "on",
            exportPdf = "onSave",
          },
        },
        texlab = {},
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
        gopls = {
          staticcheck = true,
        },
        sqlls = {},
        taplo = {},
        lemminx = {},
        opencl_ls = {},
        yamlls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
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
      setup = {
        jdtls = function()
          return true
        end,
      },
    },
    setup = function(_, _)
      local Util = require("lazyvim.util")
      Util.lsp.on_attach(function(client, buffer)
        require("config.lsp-keymap").on_attach(client, buffer)
      end)

      vim.cmd([[highlight LspInlayHint guibg=#1A1B26]])
    end,
  },
  {
    "DashieTM/null.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),

        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.autopep8,
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.typst,
        },
      }
    end,
  },
}
