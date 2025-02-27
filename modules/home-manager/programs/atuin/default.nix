{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.atuin;
in {
  options.internal.programs.atuin = {
    enable = mkEnableOption "atuin";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      daemon.enable = true;
    };
  };
}
