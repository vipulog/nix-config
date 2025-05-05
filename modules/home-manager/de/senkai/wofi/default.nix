{
  config,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  imports = [
    ./config.nix
    ./style.nix
  ];

  config = mkIf senkaiCfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
