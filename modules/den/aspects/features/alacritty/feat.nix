{self, ...}: {
  den.aspects.alacritty = {
    homeManager = {
      imports = [self.wrappers.alacritty.install];

      wrappers.alacritty = {
        enable = true;
      };
    };
  };
}
