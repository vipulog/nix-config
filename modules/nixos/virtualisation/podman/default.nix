{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.virtualisation.podman;
in {
  options.${namespace}.virtualisation.podman = {
    enable = lib.mkEnableOption "virtualisation with podman";
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
