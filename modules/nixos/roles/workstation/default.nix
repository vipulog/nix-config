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
      system = {
        boot.enable = true;
        security.sudo.enable = true;
        networking.enable = true;
        locale.enable = true;
        time.enable = true;
        audio.enable = true;
        graphics.enable = true;
      };

      users = {
        enable = true;
        vipul.enable = true;
      };

      de.gnome.enable = true;

      services = {
        flatpak.enable = true;
        openssh.enable = true;
        tailscale.enable = true;
      };

      misc = {
        nix.enable = true;
        home-manager.enable = true;
        sops.enable = true;
        disko = {
          enable = true;
          presets.single-disk-ext4.enable = true;
        };
      };
    };
  };
}
