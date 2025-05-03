{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.profiles.graphical;
in {
  options.internal.profiles.graphical = {
    enable = mkEnableOption "graphical profile";
  };

  config = mkIf cfg.enable {
    internal = {
      programs = {
        ghostty.enable = true;
        zen-browser.enable = true;
      };

      services = {
        redirector.enable = true;
      };
    };
  };
}
