{self, ...}: let
  inherit (self.lib.den.ssh) mkUserIdFilePath;
in {
  den.aspects.ssh = {
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
