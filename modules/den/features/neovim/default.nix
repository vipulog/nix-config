{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = {
    nixos = {
      environment.variables = {
        EDITOR = "nvim";
      };
    };

    homeManager = {
      imports = [inputs.nvf.homeManagerModules.default];

      programs.nvf = {
        enable = true;

        settings = {
          imports = [self.nvfModules.default];
        };
      };

      systemd.user.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };

    persist-user = {
      directories = [
        ".local/share/nvf"
        ".local/state/nvf"
      ];
    };
  };
}
