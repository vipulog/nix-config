{ inputs, ... }:
let lib = inputs.nixpkgs.lib; in {
  relativeToRoot = lib.path.append ../.;

  scanPaths = path:
    let
      isValidType = path: _type:
        (_type == "directory") ||
        (path != "default.nix" && lib.strings.hasSuffix ".nix" path);
    in
    builtins.map
      (f: "${path}/${f}")
      (builtins.attrNames (lib.attrsets.filterAttrs isValidType (builtins.readDir path)));

  nixosSystem = args: lib.nixosSystem {
    specialArgs = {
      mylib = import ./. { inherit inputs; };
      system = args.system;
      disk_device = args.disk_device;
      username = args.username;
      hostname = args.hostname;
      de = args.de;
      theme = args.theme;
      lib = lib;

      inherit inputs;

      pkgs = import inputs.nixpkgs {
        system = args.system;
        config.allowUnfree = true;
      };

    } // (if args ? specialArgs then args.specialArgs else { });

    modules = [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      ../disk-config.nix
      { _module.args.device = args.disk_device; }
      ../host
      ../user
      ../core
      ../environment
      ../theme
    ] ++ (if args ? modules then args.modules else [ ]);
  };
}
