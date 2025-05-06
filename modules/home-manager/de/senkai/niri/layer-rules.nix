{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.layer-rules = [
      {
        matches = [{namespace = "^notifications$";}];
        block-out-from = "screencast";
      }
    ];
  };
}
