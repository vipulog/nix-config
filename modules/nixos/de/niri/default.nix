{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  options.internal.de.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };

    environment = {
      variables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        xwayland-satellite
        wl-clipboard
      ];
    };
  };
}
