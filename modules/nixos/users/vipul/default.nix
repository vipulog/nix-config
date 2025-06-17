{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.users.vipul;
in {
  options.internal.users.vipul = {
    enable = mkEnableOption "configuration for user \"vipul\"";
    isAdmin = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to add this user to wheel group.";
    };
  };

  config = mkIf cfg.enable {
    users.users.vipul = {
      isNormalUser = true;
      initialPassword = "1";
      shell = pkgs.zsh;
      extraGroups = lists.optionals cfg.isAdmin ["wheel"];
    };
  };
}
