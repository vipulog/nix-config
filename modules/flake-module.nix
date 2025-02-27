{
  flake = {
    nixosModules = rec {
      all = ./nixos;
      default = all;
    };
    homeModules = rec {
      all = ./home-manager;
      default = all;
    };
    nixOnDroidModules = rec {
      all = ./nix-on-droid;
      default = all;
    };
  };
}
