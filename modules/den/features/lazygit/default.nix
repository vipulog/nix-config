{
  den.aspects.lazygit = {
    homeManager = {pkgs, ...}: {
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

    persist-user = {
      directories = [
        ".local/state/lazygit"
      ];
    };
  };
}
