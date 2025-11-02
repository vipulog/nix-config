{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.services.openssh;
in {
  options.${namespace}.services.openssh = {
    enable = lib.mkEnableOption "openssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh.enable = true;
  };
}
