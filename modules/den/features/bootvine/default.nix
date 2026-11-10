{inputs, ...}: {
  flake-file.inputs = {
    bootvine = {
      url = "git+https://codeberg.org/wvhulle/bootvine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.bootvine = {
    nixos = {
      imports = [inputs.bootvine.nixosModules.default];
      services.bootvine.enable = true;
    };
  };
}
