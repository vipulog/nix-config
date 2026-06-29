{
  den,
  lib,
  ...
}: {
  den.aspects.lazygit = {
    host,
    user ? null,
    ...
  }: let
    isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;
  in {
    nixos = {
      config = lib.mkMerge [
        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
            users = lib.mkIf (user != null) {
              ${user.name}.directories = [
                {
                  directory = ".local/state/lazygit";
                  mode = "0700";
                }
              ];
            };
          };
        })
      ];
    };

    homeManager = {pkgs, ...}: {
      programs.lazygit = {
        enable = true;

        settings = {
          git.pagers = [
            {pager = "${pkgs.delta}/bin/delta --dark --paging=never";}
          ];

          gui = {
            expandFocusedSidePanel = true;
            nerdFontsVersion = "3";
          };
        };
      };
    };
  };
}
