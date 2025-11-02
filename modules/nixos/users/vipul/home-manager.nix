{
  username,
  sopsCfg,
  ...
}: {
  lib,
  config,
  hostname,
  ...
}: let
  userCfg = config.users.users.${username};
in {
  config = lib.mkIf (sopsCfg.enable) {
    sops.secrets = {
      "keys/age/${username}_${hostname}" = {
        owner = userCfg.name;
        inherit (userCfg) group;
        path = "${userCfg.home}/.config/sops/age/keys.txt";
      };
    };
  };
}
