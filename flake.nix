{
  description = "Vipul's nix configuration for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      nixosConfigurations =
        let mylib = import ./lib { inherit inputs; }; in {
          desktop = mylib.nixosSystem {
            system = "x86_64-linux";
            disk_device = "/dev/sdb";
            username = "vipul";
            hostname = "desktop";
            de = "gnome";
            theme = "winter-forest";
          };
        };
    };
}
