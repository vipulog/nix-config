{
  inputs,
  config,
  namespace,
  lib,
  self,
  specialArgs,
  ...
}: let
  cfg = config.${namespace}.misc.home-manager;
in {
  imports = [inputs.home-manager.nixosModules.default];

  options.${namespace}.misc.home-manager = {
    enable = lib.mkEnableOption "home-manager";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = specialArgs;
      sharedModules = [self.homeModules.default];
    };
  };
}
