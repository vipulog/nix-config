{inputs, ...}: {
  imports = [inputs.wrapper-modules.flakeModules.wrappers];

  flake-file.inputs = {
    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
