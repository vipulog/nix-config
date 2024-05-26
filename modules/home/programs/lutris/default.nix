{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.lutris;
in {
  options.${namespace}.programs.lutris = {
    enable = lib.mkEnableOption "lutris";
  };

  config = lib.mkIf cfg.enable {
    programs.lutris = {
      enable = true;

      winePackages = with pkgs; [
        wineWowPackages.unstableFull
        wineWowPackages.stableFull
      ];

      protonPackages = with pkgs; [
        proton-ge-bin
      ];

      extraPackages = with pkgs; [
        mangohud
        winetricks
        gamescope
        gamemode
        umu-launcher
      ];
    };
  };
}
