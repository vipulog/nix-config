{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.system.graphics;
in {
  options.${namespace}.system.graphics = {
    enable = lib.mkEnableOption "graphics";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
