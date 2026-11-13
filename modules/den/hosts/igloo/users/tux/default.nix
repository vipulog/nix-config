{den, ...}: {
  den.aspects.igloo.provides.tux = {
    includes = [
      den.aspects.sops-nix
      den.aspects.tailscale
      den.aspects.podman
      den.aspects.distrobox
      den.aspects.waydroid
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

    secrets = {
      nixos = {
        lib,
        host,
        ...
      }:
        lib.mkIf (host.hasAspect den.aspects.sops-nix) {
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
        lib.mkIf (host.hasAspect den.aspects.sops-nix) {
          hashedPasswordFile = config.sops.secrets.tux-password.path;
        };
    };

    persist-user = {
      directories = {
        "DCIM".enable = true;
        "Recordings".enable = true;
      };
    };
  };
}
