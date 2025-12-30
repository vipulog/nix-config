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
    home.activation.deployLutrisConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p $HOME/.local/share/lutris
      if [ ! -e "$HOME/.local/share/lutris/lutris.conf" ]; then
        cp ${./lutris.conf} "$HOME/.local/share/lutris/lutris.conf"
      fi
    '';

    programs.lutris = {
      enable = true;

      winePackages = with pkgs; [
        wineWowPackages.unstableFull
        wineWowPackages.stableFull
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
