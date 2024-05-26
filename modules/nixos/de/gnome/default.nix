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

    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/mutter" = {
            experimental-features = [
              # Enables fractional scaling (125% 150% 175%)
              # "scale-monitor-framebuffer"
              # Enables Variable Refresh Rate (VRR) on compatible displays
              # "variable-refresh-rate"
              # Scales Xwayland applications to look crisp on HiDPI screens
              "xwayland-native-scaling"
            ];
          };
        };
      }
    ];
  };
}
