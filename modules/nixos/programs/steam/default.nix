{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.programs.steam;
in {
  options.${namespace}.programs.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };
}
