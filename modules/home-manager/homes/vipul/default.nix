{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.home.vipul;
in {
  options.internal.home.vipul = {
    enable = mkEnableOption "user-specific home configurations for vipul";
  };

  config = mkIf cfg.enable {
    home = {
      username = "vipul";
      homeDirectory = "/home/vipul";

      packages = with pkgs; [
        coreutils # basic gnu utils
      ];
    };
  };
}
