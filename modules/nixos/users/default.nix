{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.users;
  sopsEnabled = config.${namespace}.misc.sops.enable;
in {
  imports = [./vipul];

  options.${namespace}.users = {
    enable = lib.mkEnableOption "users";
  };

  config = lib.mkIf (cfg.enable && sopsEnabled) {
    users.mutableUsers = false;
  };
}
