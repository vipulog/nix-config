{
  lib,
  den,
  ...
}: {
  den = {
    hosts.x86_64-linux = {
      igloo.users.tux = {};
    };

    default.includes = [
      den.batteries.inputs'
      den.batteries.self'
      den.batteries.hostname

      den.aspects.nix
      den.aspects.nur
      den.aspects.localization
      den.aspects.home-manager
    ];

    schema.user = {
      includes = [den.policies.persist-user];
      classes = lib.mkDefault ["homeManager"];
    };

    quirks = {
      persist-host.description = "Host-level persist";
      persist-user.description = "User-level persist";
    };

    policies = let
      inherit (den.lib) policy;
      inherit (policy) pipe;
    in {
      persist-user = {user, ...}: [
        (pipe.from "persist-user" [
          (pipe.transform (i: i // {username = user.name;}))
          pipe.expose
        ])
      ];
    };
  };
}
