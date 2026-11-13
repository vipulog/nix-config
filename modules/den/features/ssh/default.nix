{self, ...}: let
  inherit (self.lib.den.ssh) mkHostIdFilePath mkUserIdFilePath;
in {
  den.aspects.ssh = {
    os = {host, ...}: {
      services.openssh = {
        enable = true;

        settings = {
          PermitRootLogin = "prohibit-password";
          PasswordAuthentication = false;
        };

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
      files = {
        "${mkHostIdFilePath {inherit host;}}" = {
          enable = true;
          how = "symlink";
          configureParent = true;
          mode = "0600";
        };
      };
    };

    persist-user = {
      user,
      host ? null,
      ...
    }: {
      directories = {
        ".ssh" = {
          enable = true;
          mode = "0700";
        };
      };

      files = {
        "${mkUserIdFilePath {inherit host user;}}" = {
          enable = true;
          mode = "0600";
        };
      };
    };
  };
}
