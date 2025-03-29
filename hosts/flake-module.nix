{
  withSystem,
  inputs,
  self,
  lib,
  ...
}:
with lib; let
  mkNixosConfig = system: host:
    withSystem system (ctx:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit (ctx) inputs' self' pkgsStable pkgsUnstable;
          inherit inputs system host self;
          packages = ctx.config.packages or {};
        };
        modules = [
          {nixpkgs.pkgs = ctx.pkgs;}
          self.nixosModules.default
          "${platformDirs.nixos}/${system}/${host}"
        ];
      });

  # Directory paths mapped to platform names
  platformDirs = {
    nixos = ./nixos;
  };

  # Configuration builders for each platform
  builders = {
    nixos = mkNixosConfig;
  };

  # Helper functions for host discovery
  getHostsForSystem = platformName: system:
    pipe (builtins.readDir (platformDirs.${platformName} + "/${system}")) [
      (filterAttrs (_: type: type == "directory"))
      attrNames
    ];

  # Helper function to create a configuration for a single host
  createHostConfiguration = platformName: system: host: {
    name = host;
    value = builders.${platformName} system host;
  };

  # Helper function to generate configurations for all hosts in a single system
  createSystemConfigurations = platformName: system: let
    systemPath = platformDirs.${platformName} + "/${system}";
  in
    if builtins.pathExists systemPath
    then map (createHostConfiguration platformName system) (getHostsForSystem platformName system)
    else [];

  # Generate configurations for all systems and hosts for a given platform
  makeConfigurations = platformName: let
    systems = attrNames self.allSystems;
    systemConfigurations = map (createSystemConfigurations platformName) systems;
  in
    listToAttrs (flatten systemConfigurations);
in {
  flake = {
    nixosConfigurations = makeConfigurations "nixos";
  };
}
