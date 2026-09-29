{den, ...}: {
  den.aspects.tailscale = let
    inherit (den.lib) policy;

    hasSops = {host ? null, ...}:
      host != null && host.hasAspect den.aspects.sops-nix;
  in {
    includes = [
      (policy.when hasSops (policy.include den.aspects.tailscale.secrets))
    ];

    nixos = {
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

    secrets = {
      nixos = {config, ...}: {
        sops.secrets.tailscale-auth-key = {};

        services.tailscale = {
          authKeyFile = config.sops.secrets.tailscale-auth-key.path;
        };
      };
    };

    persist = {
      preserve.directories = [
        "/var/lib/tailscale"
      ];
    };
  };
}
