{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.system.fonts;
in {
  options.internal.system.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
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
