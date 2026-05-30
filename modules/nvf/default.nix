{
  inputs,
  self,
  ...
}: {
  flake-file.inputs = {
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.neovimModules = {
    default = import ./_modules/default.nix;
    min = import ./_modules/min.nix;
    max = import ./_modules/max.nix;
  };

  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages = let
      mkNeovimCfg = modName: (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [self.neovimModules.${modName}];
      });

      mkNeovim = modName: (mkNeovimCfg modName).neovim;
    in {
      neovim-default = mkNeovim "default";
      neovim-min = mkNeovim "min";
      neovim-max = mkNeovim "max";

      neovim = self'.packages.neovim-default;
    };
  };
}
