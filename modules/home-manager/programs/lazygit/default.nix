{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.lazygit;
in {
  options.internal.programs.lazygit = {
    enable = mkEnableOption "lazygit";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
