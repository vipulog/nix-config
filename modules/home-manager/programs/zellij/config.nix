{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.zellij;
in {
  config = mkIf cfg.enable {
    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  };
}
