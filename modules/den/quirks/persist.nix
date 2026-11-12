{den, ...}: {
  den = {
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

    schema.user.includes = [
      den.policies.persist-user
    ];
  };
}
