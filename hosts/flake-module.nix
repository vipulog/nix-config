{
  withSystem,
  inputs,
  self,
  lib,
  ...
}:
with lib; let
  # Creates a NixOS configuration for a specific host
  # system: Architecture (e.g., "x86_64-linux")
  # host: Hostname/configuration name
  # Returns: A nixosSystem derivation
  mkNixosConfig = system: host:
    withSystem system (ctx:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit (ctx) inputs' self' pkgsStable pkgsUnstable;
          inherit inputs system host self;
        };
        modules = [
          self.nixosModules.default
          "${platformDirs.nixos}/${system}/${host}"
          {nixpkgs.pkgs = ctx.pkgs;}
        ];
      });

  # Map of platform names to their base directories
  # Used to locate platform-specific configurations in a consistent way
  platformDirs = {
    nixos = ./nixos;
  };

  # Map of platform names to their configuration builder functions
  # This allows us to use a generic approach for different platforms
  builders = {
    nixos = mkNixosConfig;
  };

  # Top-level function to create all configurations for a platform
  # Returns: An attribute set mapping hostnames to their configurations
  # Example: { "desktop" = <nixos-config>; "laptop" = <nixos-config>; }
  makeConfigurations = platformName: let
    systems = getSystemsForPlatform platformName;
    systemConfigurations = map (createSystemConfigurations platformName) systems;
  in
    listToAttrs (flatten systemConfigurations);

  # Generates configurations for all hosts of a specific system and platform
  # Returns an empty list if the system directory doesn't exist
  # This helps avoid errors when a platform doesn't support a particular system
  createSystemConfigurations = platformName: system: let
    systemPath = platformDirs.${platformName} + "/${system}";
  in
    if builtins.pathExists systemPath
    then map (createHostConfiguration platformName system) (getHostsForSystem platformName system)
    else [];

  # Creates a single name/value pair for a host configuration
  # Returns: { name = "hostname"; value = <nixos-configuration>; }
  createHostConfiguration = platformName: system: host: {
    name = host;
    value = builders.${platformName} system host;
  };

  # Returns the system architectures available for a given platform.
  # Example: getSystemsForPlatform "nixos" might return ["x86_64-linux" "aarch64-linux"]
  # if those system directories exist
  getSystemsForPlatform = platformName:
    pipe (builtins.readDir (platformDirs.${platformName})) [
      # Filter to only include directories (each directory = one host)
      (filterAttrs (_: type: type == "directory"))
      # Extract just the directory names (host names)
      attrNames
    ];

  # Returns all host configurations for a given platform and system
  # Example: getHostsForSystem "nixos" "x86_64-linux" might return ["desktop" "laptop"]
  # if those host directories exist
  getHostsForSystem = platformName: system:
    pipe (builtins.readDir (platformDirs.${platformName} + "/${system}")) [
      # Filter to only include directories (each directory = one host)
      (filterAttrs (_: type: type == "directory"))
      # Extract just the directory names (host names)
      attrNames
    ];
in {
  flake = {
    nixosConfigurations = makeConfigurations "nixos";
  };
}
