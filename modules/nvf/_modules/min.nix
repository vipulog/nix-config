{pkgs, ...}: {
  vim = {
    viAlias = true;
    vimAlias = true;
    vendoredKeymaps.enable = true;

    searchCase = "smart";
    preventJunkFiles = true;
    lineNumberMode = "number";
    syntaxHighlighting = true;

    options = {
      mouse = "a";
      undofile = true;
      breakindent = true;
      cursorline = true;
      signcolumn = "yes";
      splitbelow = true;
      splitright = true;
      termguicolors = true;
      wrap = true;
      incsearch = true;
      infercase = true;
      smartindent = true;
    };

    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
    };

    mini = {
      basics = {
        enable = true;

        setupOpts = {
          options = {
            basic = true;
            extra_ui = true;
          };

          mappings = {
            basic = true;
            windows = true;
            move_with_alt = true;
          };

          autocommands = {
            basic = true;
            relnum_in_visual_mode = true;
          };
        };
      };
    };

    theme = {
      enable = true;
      transparent = true;
    };

    languages = {
      enableFormat = true;

      bash.enable = true;
      env.enable = true;
      json.enable = true;
      nix.enable = true;
      toml.enable = true;
      yaml.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;

      lspconfig.enable = true;
      trouble.enable = true;
    };

    treesitter = {
      enable = true;
    };

    autocomplete = {
      blink-cmp.enable = true;
    };

    telescope = {
      enable = true;
    };

    formatter = {
      conform-nvim.enable = true;
    };

    diagnostics = {
      enable = true;
      nvim-lint.enable = true;
    };

    visuals = {
      indent-blankline = {
        enable = true;
        setupOpts.indent.char = "╎";
      };
    };

    extraPackages = [
      pkgs.git
      pkgs.luajitPackages.tree-sitter-cli
      pkgs.ripgrep
      pkgs.fd
    ];
  };
}
