{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;
        datestr = "";
        timestr = "%H:%M";
        indicator-idle-visible = true;
        indicator-radius = 100;
        effect-blur = "7x3";
        effect-scale = 2;
        effect-vignette = "0.5:0.5";
      };
    };
  };
}
