{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.system.time;
in {
  options.internal.system.time = with types; {
    enable = mkEnableOption "timezone configuration";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Asia/Kolkata";
  };
}
