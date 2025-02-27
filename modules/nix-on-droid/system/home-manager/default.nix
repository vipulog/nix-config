{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.system.home-manager;
in {
  options.internal.system.home-manager = {
    enable = mkEnableOption "home manager configuration";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
