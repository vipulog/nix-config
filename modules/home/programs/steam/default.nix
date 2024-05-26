{
  pkgs,
  config,
  lib,
  namespace,
  osConfig ? {},
  ...
}: let
  cfg = config.${namespace}.programs.steam;
  steamPackage =
    if (osConfig ? osConfig.programs.steam.enable)
    then osConfig.programs.steam.package
    else pkgs.steam;
in {
  options.${namespace}.programs.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        steamPackage
        protonup
        mangohud
        gamescope
        gamemode
      ];

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    };
  };
}
