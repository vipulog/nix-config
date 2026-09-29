{
  den.aspects.lazygit = {user}: {
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

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/state/lazygit"
      ];
    };
  };
}
