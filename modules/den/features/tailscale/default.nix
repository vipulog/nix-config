{den, ...}: {
  den.aspects.tailscale = {
    os = {
      lib,
      host,
      config,
      ...
    }: {
      config = lib.mkMerge [
        {
          services.tailscale = {
            enable = true;
            extraSetFlags = ["--ssh"];
          };
        }

        (lib.mkIf (host.hasAspect den.aspects.sops-nix) {
          sops.secrets.tailscale-auth-key = {};

          services.tailscale = {
            authKeyFile = config.sops.secrets.tailscale-auth-key.path;
          };
        })
      ];
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

    persist-host = {
      directories = {
        "/var/lib/tailscale".enable = true;
      };
    };
  };
}
