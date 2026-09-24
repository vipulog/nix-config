{self, ...}: let
  inherit (self.lib.den.ssh) mkHostIdFilePath mkUserIdFilePath;
in {
  den.aspects.ssh = {
    nixos = {host, ...}: {
      services.openssh = {
        enable = true;

        hostKeys = [
          {
            path = mkHostIdFilePath {inherit host;};
            type = "ed25519";
          }
        ];
      };
    };

    homeManager = {
      user,
      host ? null,
      ...
    }: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings."*" = {
          IdentityFile = "~/${mkUserIdFilePath {inherit host user;}}";
          IdentitiesOnly = "yes";
          AddKeysToAgent = "yes";
          ForwardAgent = "yes";
        };
      };
    };

    persist-host = {host, ...}: {
      files = [
        {
          file = mkHostIdFilePath {inherit host;};
          how = "symlink";
          configureParent = true;
          mode = "0600";
        }
      ];
    };

    persist-user = {
      user,
      host ? null,
      ...
    }: {
      directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];

      files = [
        {
          file = mkUserIdFilePath {inherit host user;};
          mode = "0600";
        }
      ];
    };
  };
}
