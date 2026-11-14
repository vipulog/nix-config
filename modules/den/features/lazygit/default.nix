{
  den.aspects.lazygit = let
    sharedModule = {pkgs, ...}: {
      programs.lazygit = {
        enable = true;

        settings = {
          git.diffRenderers = [
            {command = "${pkgs.delta}/bin/delta --dark --paging=never";}
          ];

          gui = {
            expandFocusedSidePanel = true;
            nerdFontsVersion = "3";
          };
        };
      };
    };
  in {
    nixos = {
      imports = [sharedModule];
    };

    darwin = {pkgs, ...}: {
      environment.systemPackages = [pkgs.lazygit];
    };

    homeManager = {
      imports = [sharedModule];
    };

    persist-user = {
      directories = {
        ".local/state/lazygit".enable = true;
      };
    };
  };
}
