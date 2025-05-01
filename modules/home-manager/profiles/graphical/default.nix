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
      misc.stylix.enable = true;
      de.niri.enable = true;
      services.swayosd.enable = true;
      programs = {
        ghostty.enable = true;
        zen-browser.enable = true;
      };
    };
  };
}
