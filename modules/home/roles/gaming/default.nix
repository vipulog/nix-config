{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.roles.gaming;
in {
  options.${namespace}.roles.gaming = {
    enable = lib.mkEnableOption "gaming role";
  };

  config = lib.mkIf cfg.enable {
    ${namespace}.programs = {
      steam.enable = true;
      lutris.enable = true;
      cartridges.enable = true;
    };

    home = {
      packages = with pkgs; [
        mangohud
        gamescope
        gamemode
        wineWow64Packages.full
      ];
    };
  };
}
