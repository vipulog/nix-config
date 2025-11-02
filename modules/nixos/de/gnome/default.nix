{
  pkgs,
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.de.gnome;
in {
  options.${namespace}.de.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour # First launch tutorial
      simple-scan # Document Scanner
      epiphany # GNOME Web browser
      yelp # Help viewer
    ];
  };
}
