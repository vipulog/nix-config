{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.wl-clipboard;
in {
  options.${namespace}.programs.wl-clipboard = {
    enable = lib.mkEnableOption "wl-clipboard";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.wl-clipboard];
  };
}
