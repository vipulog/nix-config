{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.roles.workstation;
in {
  options.${namespace}.roles.workstation = {
    enable = lib.mkEnableOption "workstation role";
  };

  config = lib.mkIf cfg.enable {
    ${namespace} = {
      users.vipul.enable = true;

      de.gnome.enable = true;

      programs = {
        coreutils.enable = true;
        home-manager.enable = true;
        zsh.enable = true;
        ssh.enable = true;
        git.enable = true;
        btop.enable = true;
        atuin.enable = true;
        zoxide.enable = true;
        eza.enable = true;
        bat.enable = true;
        direnv.enable = true;
        lazygit.enable = true;
        starship.enable = true;
        ghostty.enable = true;
        chromium.enable = true;
        zen-browser.enable = true;
        gemini-cli.enable = true;
        android-studio.enable = true;
        discord.enable = true;
        wl-clipboard.enable = true;

        helix = {
          enable = true;
          defaultEditor = true;
        };
      };

      services = {
        redirector.enable = true;
      };

      misc = {
        nix.enable = true;
        sops.enable = true;
        nix-index-database.enable = true;
      };
    };
  };
}
