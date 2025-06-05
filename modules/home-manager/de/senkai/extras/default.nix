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
    home.packages = [
      pkgs.nautilus
    ];
  };
}
