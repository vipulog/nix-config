{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.android-studio;
in {
  options.internal.programs.android-studio = {
    enable = mkEnableOption "android-studio";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.androidStudioPackages.dev
    ];
  };
}
