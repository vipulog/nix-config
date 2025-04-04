{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.user.vipul;
in {
  options.internal.user.vipul = {
    enable = mkEnableOption "user-specific configurations for vipul";
  };

  config = mkIf cfg.enable {};
}
