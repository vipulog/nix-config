{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.profiles.common;
in {
  options.internal.profiles.common = {
    enable = mkEnableOption "common profile";
  };

  config = mkIf cfg.enable {
    internal = {
      programs = {
        zsh.enable = true;
        git.enable = true;
        btop.enable = true;
        nnn.enable = true;
        coreutils.enable = true;
      };
    };
  };
}
