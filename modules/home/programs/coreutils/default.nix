{
  config,
  lib,
  pkgs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.coreutils;
in {
  options.${namespace}.programs.coreutils = {
    enable = lib.mkEnableOption "coreutils";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      coreutils # basic gnu utils
    ];
  };
}
