{
  den,
  inputs,
  ...
}: {
  den = {
    quirks.nixpkgs-overlays = {
      description = "nixpkgs overlays collected from aspects.";
    };

    policies.hm-overlays-to-host = {
      host ? null,
      home ? null,
      user,
      lib,
      ...
    }: let
      isHostUser = host ? class && home == null;
      hasHm = lib.elem "homeManager" (user.classes or []);
    in
      lib.optionals (isHostUser && hasHm) [
        (den.lib.policy.pipe.from "nixpkgs-overlays" [
          den.lib.policy.pipe.expose
        ])
      ];

    aspects.nixpkgs = let
      sharedConfig = {
        problems.handlers."gtk+".broken = "warn";
      };

      unstableConfig = sharedConfig;
      stableConfig = sharedConfig // {rewriteURL = url: url;};
    in {
      os = {
        lib,
        nixpkgs-overlays,
        ...
      }: {
        nixpkgs = {
          config = sharedConfig;
          overlays = lib.unique nixpkgs-overlays;
        };
      };

      homeManager = {
        lib,
        osConfig ? null,
        nixpkgs-overlays,
        ...
      }: let
        useHostPkgs = osConfig.home-manager.useGlobalPkgs or false;
      in {
        config = lib.mkIf (!useHostPkgs) {
          nixpkgs = {
            config = sharedConfig;
            overlays = lib.unique nixpkgs-overlays;
          };
        };
      };

      nixpkgs-overlays = _: [
        (final: _prev: {
          stable = import inputs.nixpkgs-stable {
            inherit (final.stdenv.hostPlatform) system;
            config = stableConfig;
          };
        })

        (final: _prev: {
          unstable = import inputs.nixpkgs {
            inherit (final.stdenv.hostPlatform) system;
            config = unstableConfig;
          };
        })
      ];
    };
  };
}
