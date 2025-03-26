{
  config,
  lib,
  host,
  ...
}:
with lib; let
  cfg = config.internal.services.networking;
  userAttrs = listToAttrs (map addGroup cfg.users);

  addGroup = user: {
    name = user;
    value = {extraGroups = ["networkmanager"];};
  };
in {
  options.internal.services.networking = {
    enable = mkEnableOption "networking";

    users = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of users to add to the networkmanager group.";
    };
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      hostName = host;
    };
    users.users = userAttrs;
  };
}
