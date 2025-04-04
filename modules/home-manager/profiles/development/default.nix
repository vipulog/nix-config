{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.profiles.development;
in {
  options.internal.profiles.development = {
    enable = mkEnableOption "development profile";
  };

  config = mkIf cfg.enable {
    internal = {
      programs = {
        git.enable = true;
        lazygit.enable = true;
        helix.enable = true;
        atuin.enable = true;
        starship.enable = true;
        zoxide.enable = true;
        direnv.enable = true;
      };
    };
  };
}
