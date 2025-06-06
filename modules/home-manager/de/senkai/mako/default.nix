{
  config,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
  colors = config.lib.stylix.colors.withHashtag;
in {
  config = mkIf senkaiCfg.enable {
    services.mako = {
      enable = true;
      settings = {
        font = mkForce "monospace 12";
        margin = "4";
        outer-margin = "0";
        padding = "8";
        width = "320";
        border-color = mkForce colors.base03;
        border-size = 3;
      };
    };
  };
}
