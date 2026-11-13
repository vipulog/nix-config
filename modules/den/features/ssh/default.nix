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
            path = mkHostIdFilePath {hostname = host.name;};
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
          IdentityFile = "~/${
            mkUserIdFilePath {
              username = user.name;
              hostname = host.name or null;
            }
          }";

          IdentitiesOnly = "yes";
          AddKeysToAgent = "yes";
          ForwardAgent = "yes";
        };
      };
    };

    persist-host = {host, ...}: {
      files = {
        "${mkHostIdFilePath {hostname = host.name;}}" = {
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
        "${mkUserIdFilePath {
          username = user.name;
          hostname = host.name or null;
        }}" = {
          enable = true;
          mode = "0600";
        };
      };
    };
  };
}
