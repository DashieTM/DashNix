{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # Telescope
      ripgrep
      # lua
      lua-language-server
      stylua
      # nix
      nil
      # go
      gopls
      # jafuck
      jdt-language-server
      taplo
      typst-lsp
      sqls
      shfmt
      texlab
      nixpkgs-fmt
      crate2nix
      ruff-lsp
      nodePackages.pyright
      lemminx
      marksman
      clang-tools_18
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          # LazyVim
          LazyVim
          bufferline-nvim
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp_luasnip
          conform-nvim
          dashboard-nvim
          dressing-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          indent-blankline-nvim
          lualine-nvim
          neo-tree-nvim
          neoconf-nvim
          neodev-nvim
          noice-nvim
          nui-nvim
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-notify
          nvim-spectre
          nvim-treesitter.withAllGrammars
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-web-devicons
          nvim-jdtls
          neotest
          neotest-java
          neotest-rust
          persistence-nvim
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          vim-illuminate
          vim-startuptime
          which-key-nvim
          { name = "LuaSnip"; path = luasnip; }
          #{ name = "catppuccin"; path = catppuccin-nvim; }
          { name = "mini.ai"; path = mini-nvim; }
          { name = "mini.bufremove"; path = mini-nvim; }
          { name = "mini.comment"; path = mini-nvim; }
          { name = "mini.indentscope"; path = mini-nvim; }
          { name = "mini.pairs"; path = mini-nvim; }
          { name = "mini.surround"; path = mini-nvim; }
        ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          performance = {
            rtp = {
              disabled_plugins = {
                "gzip",
                "netrw",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
              },
            },
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "." },
            -- fallback to download
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            { import = "lazyvim.plugins.extras.ui.alpha" },
            { import = "lazyvim.plugins.extras.lang.rust" },
            { import = "lazyvim.plugins.extras.lang.tailwind" },
            { import = "lazyvim.plugins.extras.lang.java" },
            { import = "lazyvim.plugins.extras.lang.go" },
            { import = "lazyvim.plugins.extras.lang.clangd" },
            { import = "lazyvim.plugins.extras.lang.typescript" },
            { import = "lazyvim.plugins.extras.lang.python" },
            { import = "lazyvim.plugins.extras.lang.markdown" },
            { import = "lazyvim.plugins.extras.lang.cmake" },
            { import = "lazyvim.plugins.extras.lang.omnisharp" },
            { import = "lazyvim.plugins.extras.lang.json" },
            { import = "lazyvim.plugins.extras.lang.tex" },
            { import = "lazyvim.plugins.extras.util.dot" },
            { import = "lazyvim.plugins.extras.dap.core" },
            { import = "lazyvim.plugins.extras.test.core" },
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            --{ "williamboman/mason.nvim", enabled = false },
            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
            { import = "plugins" },
            { import = "plugins.plugins" },
          },
          install = { colorscheme = { "tokyonight" } },
          checker = { enabled = true, notify = false },
          change_detection = { enabled = true, notify = false },
        })
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/ftplugin".source = ./ftplugin;
}
