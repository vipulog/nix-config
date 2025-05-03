{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.coreutils;
in {
  options.internal.programs.coreutils = {
    enable = mkEnableOption "coreutils";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      coreutils # basic gnu utils
    ];
  };
}
