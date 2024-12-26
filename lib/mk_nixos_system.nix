{ inputs, ... }: let lib = inputs.nixpkgs.lib; in {
  mkNixosSystem = args: lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      system = args.system;
      hostname = args.hostname;
      username = args.username;
    } // (if args ? specialArgs then args.specialArgs else { });

    modules = [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      ../host
      ../core
      ../user
    ] ++ (if args ? modules then args.modules else [ ]);
  };
}
