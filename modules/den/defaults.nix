{
  lib,
  den,
  ...
}: {
  den = {
    default = {
      includes = [
        den.batteries.inputs'
        den.batteries.self'
        den.policies.expose-persist
      ];
    };

    schema = {
      host = {
        includes = [
          den.batteries.hostname
          den.aspects.nix
          den.aspects.home-manager
          den.aspects.nur
          den.aspects.localization
        ];
      };

      user = {
        includes = [
          den.batteries.host-aspects
        ];

        classes = lib.mkDefault ["homeManager"];
      };
    };

    quirks = {
      persist = {
        description = "Preservation config contributed by aspects";
      };
    };

    policies = {
      expose-persist = {...}: let
        inherit (den.lib.policy) pipe;
      in [(pipe.from "persist" [pipe.expose])];
    };
  };
}
