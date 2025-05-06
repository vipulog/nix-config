{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.layout = {
      gaps = 10;

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
        place-within-column = false;
        hide-when-single-tab = false;
      };
    };
  };
}
