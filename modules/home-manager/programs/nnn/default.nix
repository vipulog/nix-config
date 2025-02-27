{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.nnn;
in {
  options.internal.programs.nnn = {
    enable = mkEnableOption "nnn";
  };

  config = mkIf cfg.enable {
    programs.nnn = {
      enable = true;
    };
  };
}
