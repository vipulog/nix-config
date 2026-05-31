{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = {
    homeManager = {pkgs, ...}: let
      neovimCfg = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [self.neovimModules.default];
      };
    in {
      home.packages = [neovimCfg.neovim];
    };
  };
}
