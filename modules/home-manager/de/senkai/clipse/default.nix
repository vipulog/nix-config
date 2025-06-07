{
  config,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    services.clipse = {
      enable = true;
      historySize = 100;
      allowDuplicates = false;
      imageDisplay = {
        type = "kitty";
        scaleX = 24;
        scaleY = 24;
        heightCut = 8;
      };
    };
  };
}
