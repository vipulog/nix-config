{den, ...}: {
  den.aspects.tailscale = {
    includes = [den.aspects.tailscale.secrets];

    os = {
      services.tailscale = {
        enable = true;
        extraSetFlags = ["--ssh"];
      };
    };

    homeManager = {pkgs, ...}: let
      package = pkgs.trayscale;
    in {
      home.packages = [package];

      services.trayscale = {
        enable = true;
        inherit package;
      };
    };

    secrets = {
      nixos = {
        lib,
        host,
        config,
        ...
      }:
        lib.mkIf (host.hasAspect den.aspects.sops-nix) {
          sops.secrets.tailscale-auth-key = {};

          services.tailscale = {
            authKeyFile = config.sops.secrets.tailscale-auth-key.path;
          };
        };
    };

    persist-host = {
      directories = {
        "/var/lib/tailscale".enable = true;
      };
    };
  };
}
