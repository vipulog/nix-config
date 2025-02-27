{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.zoxide;
in {
  options.internal.programs.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
    };
  };
}
