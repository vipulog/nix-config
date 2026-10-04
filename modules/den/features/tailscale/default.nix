{
  den,
  self,
  ...
}: {
  den.aspects.tailscale = {
    includes = [den.aspects.tailscale.secrets];

    os = {
      services.tailscale = {
        enable = true;
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

    secrets = let
      inherit (self.lib.den.sops-nix) hostHasSops;
    in {
      nixos = {
        lib,
        host,
        config,
        ...
      }:
        lib.mkIf (hostHasSops {inherit den host;}) {
          sops.secrets.tailscale-auth-key = {};

          services.tailscale = {
            authKeyFile = config.sops.secrets.tailscale-auth-key.path;
          };
        };
    };

    persist-host = {
      directories = [
        "/var/lib/tailscale"
      ];
    };
  };
}
