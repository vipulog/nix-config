{
  inputs,
  self,
  lib,
  ...
}: let
  nixosHostsDir = ./nixos;
  nixOnDroidHostsDir = ./nix-on-droid;

  nixosHosts = lib.pipe (builtins.readDir nixosHostsDir) [
    (lib.filterAttrs (_name: type: type == "directory"))
    builtins.attrNames
  ];

  nixOnDroidHosts = lib.pipe (builtins.readDir nixOnDroidHostsDir) [
    (lib.filterAttrs (_name: type: type == "directory"))
    builtins.attrNames
  ];

  mkNixosHostConfig = hostName:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs self;};
      modules = [
        self.nixosModules.default
        "${nixosHostsDir}/${hostName}"
      ];
    };

  mkNixOnDroidHostConfig = hostName:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      specialArgs = {inherit inputs self;};
      modules = [
        self.nixOnDroidModules.default
        "${nixOnDroidHostsDir}/${hostName}"
      ];
    };

  nixosConfigurations = lib.genAttrs nixosHosts (host: mkNixosHostConfig host);
  nixOnDroidConfigurations = lib.genAttrs nixOnDroidHosts (host: mkNixOnDroidHostConfig host);
in {
  flake = {
    inherit nixosConfigurations nixOnDroidConfigurations;
  };
}
