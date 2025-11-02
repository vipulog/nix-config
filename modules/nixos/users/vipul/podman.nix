{username, ...}: {
  lib,
  config,
  namespace,
  ...
}: let
  podmanCfg = config.${namespace}.virtualisation.podman;
in {
  config = lib.mkIf (podmanCfg.enable) {
    users.users.${username} = {
      extraGroups = ["podman"];
    };
  };
}
