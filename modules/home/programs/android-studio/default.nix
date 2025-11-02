{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.android-studio;
in {
  options.${namespace}.programs.android-studio = {
    enable = lib.mkEnableOption "android-studio";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.androidStudioPackages.dev
    ];
  };
}
