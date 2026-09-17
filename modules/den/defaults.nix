{
  lib,
  den,
  ...
}: {
  den = let
    inherit (den.lib) policy;
  in {
    default = {
      includes = [
        den.batteries.inputs'
        den.batteries.self'
        den.batteries.hostname

        den.policies.expose-persist

        den.aspects.nix
        den.aspects.nur
        den.aspects.localization
        den.aspects.home-manager
      ];
    };

    schema.user = {
      includes = [den.batteries.host-aspects];
      classes = lib.mkDefault ["homeManager"];
    };

    quirks = {
      persist.description = "Preservation config contributed by aspects";
    };

    policies = {
      expose-persist = _: [
        (policy.pipe.from "persist" [policy.pipe.expose])
      ];
    };
  };
}
