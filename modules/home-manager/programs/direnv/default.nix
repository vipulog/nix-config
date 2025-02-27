{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.direnv;
in {
  options.internal.programs.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
