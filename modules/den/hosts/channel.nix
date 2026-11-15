{inputs, ...}: let
  channels = {
    stable = {
      nixosSystem = inputs.nixpkgs-stable.lib.nixosSystem;
      darwinSystem = inputs.nix-darwin-stable.lib.darwinSystem;

      hmModule = {
        nixos = inputs.home-manager-stable.nixosModules.home-manager;
        darwin = inputs.home-manager-stable.darwinModules.home-manager;
      };
    };

    unstable = {
      nixosSystem = inputs.nixpkgs.lib.nixosSystem;
      darwinSystem = inputs.nix-darwin.lib.darwinSystem;

      hmModule = {
        nixos = inputs.home-manager.nixosModules.home-manager;
        darwin = inputs.home-manager.darwinModules.home-manager;
      };
    };
  };
in {
  den.schema.host = {
    config,
    lib,
    ...
  }: {
    options.channel = lib.mkOption {
      type = lib.types.enum (builtins.attrNames channels);
      default = "unstable";
      description = "Channel / package set source for this host.";
    };

    config = {
      instantiate = lib.mkDefault (
        if config.class == "darwin"
        then channels.${config.channel}.darwinSystem
        else channels.${config.channel}.nixosSystem
      );

      home-manager.module = lib.mkDefault (
        if config.class == "darwin"
        then channels.${config.channel}.hmModule.darwin
        else channels.${config.channel}.hmModule.nixos
      );
    };
  };
}
