{
  config,
  lib,
  ...
}:
with lib; let
  niriCfg = config.internal.de.niri;
in {
  config = mkIf niriCfg.enable {
    fonts = {
      fontconfig = {
        enable = true;
        antialias = true;

        hinting = {
          enable = true;
          autohint = false;
          style = "full";
        };

        subpixel = {
          lcdfilter = "default";
          rgba = "rgb";
        };
      };

      fontDir = {
        enable = true;
        decompressFonts = true;
      };
    };
  };
}
