{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = {user}: {
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

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/share/nvf"
        ".local/state/nvf"
      ];
    };
  };
}
