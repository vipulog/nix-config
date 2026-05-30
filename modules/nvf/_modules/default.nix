{
  imports = [
    ./min.nix
    ./patches/nvim-notify-patch.nix
  ];

  vim = {
    languages = {
      css.enable = true;
      go.enable = true;
      html.enable = true;
      just.enable = true;
      markdown.enable = true;
      python.enable = true;
      svelte.enable = true;
      typescript.enable = true;
    };

    mini = {
      icons.enable = true;
    };

    utility = {
      oil-nvim = {
        enable = true;
        gitStatus.enable = true;
      };
    };

    notify = {
      nvim-notify.enable = true;
    };

    notes = {
      neorg.enable = true;
      todo-comments.enable = true;
    };

    statusline = {
      lualine.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    git = {
      gitsigns.enable = true;
    };
  };
}
