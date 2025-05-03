{
  config,
  lib,
  host,
  ...
}:
with lib; let
  cfg = config.internal.services.networking;
in {
  options.internal.services.networking = {
    enable = mkEnableOption "Enable networking configuration";

    users = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of users to add to the networking group";
    };

    group = mkOption {
      type = types.str;
      default = "networkmanager";
      description = "Group to add users to for networking access";
    };
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      hostName = host;
    };

    users.users = mkIf cfg.enable (genAttrs cfg.users (_name: {
      extraGroups = mkBefore [cfg.group];
    }));
  };
}
