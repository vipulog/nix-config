{
  config,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    services.mako = {
      enable = true;
      settings = {
        font = mkForce "monospace 12";
        margin = "8";
        outer-margin = "4";
        padding = "8";
        width = "320";
      };
    };
  };
}
