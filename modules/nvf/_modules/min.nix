{pkgs, ...}: {
  vim = {
    searchCase = "smart";
    syntaxHighlighting = true;

    mini.basics = {
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
        };
      };
    };

    clipboard = {
      enable = true;
      providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;
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
