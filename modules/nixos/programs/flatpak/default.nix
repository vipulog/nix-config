{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.flatpak;
in {
  options.internal.programs.flatpak = {
    enable = mkEnableOption "flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [
      flatpak
      gnome-software
    ];

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
