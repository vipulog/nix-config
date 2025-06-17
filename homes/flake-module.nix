{
  withSystem,
  inputs,
  self,
  lib,
  ...
}:
with lib; let
  # Creates a home-manager configuration for a specific home
  # system: Architecture (e.g., "x86_64-linux")
  # home: home-configuration name
  # Returns: A home-manager configuration
  mkHomeConfig = system: home: (
    withSystem system (
      ctx: (
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit (ctx) pkgs;
          extraSpecialArgs = {
            inherit (ctx) inputs' self' pkgsStable pkgsUnstable;
            inherit inputs system home self;
          };
          modules = [
            self.homeModules.default
            ./${system}/${home}
            {programs.home-manager.enable = true;}
          ];
        }
      )
    )
  );

  # This function dynamically creates home-manager configurations for all
  # detected systems and their respective homes.
  makeHomeConfigurations = pipe getSystems [
    # For each system architecture (e.g., "x86_64-linux", "aarch64-linux")...
    (map (system: (pipe (getHomesForSystem system) [
      # ...get all the home directories within that system (e.g., "vipul", "guest")...
      (map (home: {
        # ...and create a name for the configuration (e.g., "x86_64-linux/vipul")...
        name = home;
        # ...and define its value using the 'mkHomeConfig' function.
        value = mkHomeConfig system home;
      }))
    ])))
    # Flatten the list of lists into a single list of home configurations.
    flatten
    # Convert the list of { name, value } sets into a single attribute set,
    # where each 'name' becomes an attribute key and 'value' its corresponding value.
    listToAttrs
  ];

  # Returns all system architectures available for our homes.
  # Example: getSystems might return ["x86_64-linux" "aarch64-linux"]
  # if those system directories exist
  getSystems = pipe (builtins.readDir ./.) [
    # Filter to only include directories (each directory = one system)
    (filterAttrs (_: type: type == "directory"))
    # Extract just the directory names (system names)
    attrNames
  ];

  # Returns all homes for a given system
  # Example: getHomesForSystem "x86_64-linux" might return ["vipul" "guest"]
  # if those home directories exist
  getHomesForSystem = system: (
    pipe (builtins.readDir ./${system}) [
      # Filter to only include directories (each directory = one home)
      (filterAttrs (_: type: type == "directory"))
      # Extract just the directory names (home names)
      attrNames
    ]
  );
in {
  flake = {
    homeConfigurations = makeHomeConfigurations;
  };
}
