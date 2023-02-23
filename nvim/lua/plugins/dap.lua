return {
  {
    "mxsdev/nvim-dap-vscode-js",
    build = "npm install --legacy-peer-deps && npm run compile",
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          ensure_installed = {
            "node2",
            "python",
            "javadbg",
            "javatest",
            "codelldb",
            "firefox",
            "bash",
            "delve",
          },
          automatic_installation = true,
          automatic_setup = true,
        },
        config = function(_, opts)
          require("mason-nvim-dap").setup(opts)
          require("mason-nvim-dap").setup_handlers({
            javadbg = function() end,
          })
        end,
      },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb",
      }

      local rust_dap = vim.fn.getcwd()
      local filename = ""
      for w in rust_dap:gmatch("([^/]+)") do
        filename = w
      end

      dap.configurations.rust = {
        {
          type = "lldb",
          request = "launch",
          program = function()
            return rust_dap .. "/target/debug/" .. filename
          end,
          --program = '${fileDirname}/${fileBasenameNoExtension}',
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          terminal = "integrated",
        },
      }

      dap.configurations.cpp = {
        {
          name = "debug cpp",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          terminal = "integrated",
        },
      }
      dap.configurations.c = dap.configurations.cpp

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
      }
      dap.configurations.java = {
        {
          -- type = "javadbg",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
      dap.configurations.javascript = {
        {
          name = "Launch",
          type = "js",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }
      dap.configurations.typescript = {
        {
          name = "Debug with Firefox",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/usr/bin/firefox",
        },
      }
      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      })

      -- require("mason-nvim-dap").setup({
      --   ensure_installed = {
      --     "bash-debug-adapter",
      --     "firefox-debug-adapter",
      --     "js-debug-adapter",
      --     "node-debug2-adapter",
      --     "java-debug-adapter",
      --     "debugpy",
      --   },
      --   automatic_installation = true,
      --   automatic_setup = true,
      -- })
      -- require("mason-nvim-dap").setup_handlers({
      --   function(source_name)
      --     -- all sources with no handler get passed here
      --
      --     -- Keep original functionality of `automatic_setup = true`
      --     require("mason-nvim-dap.automatic_setup")(source_name)
      --   end,
      --   python = function(source_name)
      --     dap.adapters.python = {
      --       type = "executable",
      --       command = "/usr/bin/python3",
      --       args = {
      --         "-m",
      --         "debugpy.adapter",
      --       },
      --     }
      --
      --     dap.configurations.python = {
      --       {
      --         type = "python",
      --         request = "launch",
      --         name = "Launch file",
      --         program = "${file}", -- This configuration will launch the current file if used.
      --       },
      --     }
      --   end,
      -- })
      local dap = require("dap")
      dap.configurations.lua = {

        {

          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
