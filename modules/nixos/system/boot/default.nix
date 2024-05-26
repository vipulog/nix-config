{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.system.boot;
in {
  options.${namespace}.system.boot = {
    enable = lib.mkEnableOption "boot";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };
}
