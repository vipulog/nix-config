# misc cli utilities
{ pkgs, username, home-manager, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      nitch
      wget
      curl
      gnugrep
      gnused
      gawk
      file
      which
      tree
      rsync
      gnutar
      zip
      xz
      parted
    ];

    programs = {
      eza = {
        enable = true;
        git = true;
        icons = "auto";
      };

      bat = {
        enable = true;
        config = {
          pager = "less -FR";
        };
      };

      fzf = {
        enable = true;
      };

      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      atuin = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      zellij = {
        enable = true;
      };

      starship = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        settings = {
          add_newline = false;
          nix_shell = {
            symbol = "❄️ ";
          };
        };
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
