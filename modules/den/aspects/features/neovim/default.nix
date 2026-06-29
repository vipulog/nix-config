{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = {
    homeManager = {
      imports = [inputs.nvf.homeManagerModules.default];

      programs.nvf = {
        enable = true;

        settings = {
          imports = [self.neovimModules.default];
        };
      };
    };
  };
}
