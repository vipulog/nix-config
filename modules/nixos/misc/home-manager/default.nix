{
  inputs,
  config,
  lib,
  self,
  ...
}:
with lib; let
  cfg = config.internal.misc.home-manager;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.internal.misc.home-manager = {
    enable = mkEnableOption "home manager configuration";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = {inherit self inputs;};
    };
  };
}
