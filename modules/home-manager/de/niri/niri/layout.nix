{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  config = mkIf cfg.enable {
    programs.niri.settings.layout = {
      gaps = 4;

      shadow = {
        enable = true;
        spread = 4;
        softness = 8;

        offset = {
          x = 0;
          y = 0;
        };
      };

      tab-indicator = {
        width = 10;
        gap = 4;
        gaps-between-tabs = 4;
        corner-radius = 0;
        position = "bottom";
        place-within-column = true;
        hide-when-single-tab = true;
      };
    };
  };
}
