{
  config,
  namespace,
  lib,
  hostname,
  ...
}: let
  cfg = config.${namespace}.system.networking;
in {
  options.${namespace}.system.networking = {
    enable = lib.mkEnableOption "networking";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      hostName = hostname;
    };
  };
}
