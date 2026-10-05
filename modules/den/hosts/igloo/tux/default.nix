{
  den,
  self,
  ...
}: {
  den.aspects.igloo.provides.tux = {
    includes = [
      den.aspects.sops-nix
      den.aspects.tailscale
      den.aspects.podman
      den.aspects.distrobox
      den.aspects.waydroid
      den.aspects.niri-de
      den.aspects.kdeconnect
      den.aspects.lutris
      den.aspects.igloo.provides.tux.secrets
      den.aspects.igloo.provides.tux.syncthing
      den.aspects.igloo.provides.tux.restic
    ];

    nixos = {
      services.tailscale.extraSetFlags = [
        "--operator=tux"
      ];
    };

    homeManager = {
      home.stateVersion = "26.05";
    };

    secrets = let
      inherit (self.lib.den.sops-nix) hostHasSops;
    in {
      nixos = {
        lib,
        host,
        ...
      }:
        lib.mkIf (hostHasSops {inherit den host;}) {
          sops.secrets.tux-password = {
            neededForUsers = true;
          };
        };

      user = {
        lib,
        host,
        config,
        ...
      }:
        lib.mkIf (hostHasSops {inherit den host;}) {
          hashedPasswordFile = config.sops.secrets.tux-password.path;
        };
    };

    persist-user = {
      directories = [
        "DCIM"
        "Recordings"
      ];
    };
  };
}
