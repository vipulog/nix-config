{
  den.aspects.tailscale = {
    os = {
      services.tailscale.enable = true;
    };

    nixos = {
      lib,
      config,
      options,
      ...
    }: {
      config = lib.mkMerge [
        {
          services.tailscale = {
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

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.tailscale];
      services.trayscale.enable = true;
    };

    persist-host = {
      directories = {
        "/var/lib/tailscale".enable = true;
      };
    };
  };
}
