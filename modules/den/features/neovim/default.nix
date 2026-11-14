{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = let
    sharedModule = {
      programs.nvf = {
        enable = true;

        settings = {
          imports = [self.nvfModules.default];
        };
      };
    };
  in {
    os = {
      imports = [sharedModule];

      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };

    nixos = {
      imports = [inputs.nvf.nixosModules.default];
    };

    darwin = {
      imports = [inputs.nvf.darwinModules.default];
    };

    homeManager = {
      imports = [
        inputs.nvf.homeManagerModules.default
        sharedModule
      ];

      systemd.user.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };

    persist-user = {
      directories = {
        ".local/share/nvf".enable = true;
        ".local/state/nvf".enable = true;
      };
    };
  };
}
