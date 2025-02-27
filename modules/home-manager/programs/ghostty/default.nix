{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.ghostty;
in {
  options.internal.programs.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        window-decoration = "server";
        window-padding-x = 8;
        window-padding-y = 8;
      };
    };
  };
}
