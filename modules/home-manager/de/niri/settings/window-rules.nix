{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  config = mkIf cfg.enable {
    programs.niri.settings.window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
      }
    ];
  };
}
