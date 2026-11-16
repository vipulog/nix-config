{
  den.aspects.tailscale = {
    os = {
      lib,
      config,
      options,
      ...
    }: {
      config = lib.mkMerge [
        {
          services.tailscale = {
            enable = true;
            extraSetFlags = ["--ssh"];
          };
        }

        (lib.optionalAttrs (options ? sops) {
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
