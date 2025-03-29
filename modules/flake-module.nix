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
  };
}
