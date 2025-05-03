{
  config,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
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
