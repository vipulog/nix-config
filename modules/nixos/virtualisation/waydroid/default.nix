{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.virtualisation.waydroid;
in {
  options.${namespace}.virtualisation.waydroid = {
    enable = lib.mkEnableOption "waydroid";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.waydroid-helper];

    virtualisation.waydroid = {
      enable = true;
    };
  };
}
