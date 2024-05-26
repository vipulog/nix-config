{
  pkgs,
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.services.flatpak;
in {
  options.${namespace}.services.flatpak = {
    enable = lib.mkEnableOption "flatpak";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists \
        flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
