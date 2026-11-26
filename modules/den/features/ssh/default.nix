{
  den.aspects.ssh = let
    mkUserIdFilePath = {
      username,
      hostname ? null,
    }: let
      name =
        if hostname == null
        then "id_${username}"
        else "id_${username}_${hostname}";
    in ".ssh/${name}";
  in {
    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.openssh];
    };

    homeManager = {
      user,
      host ? null,
      lib,
      config,
      options,
      ...
    }: let
      userIdFilePath = mkUserIdFilePath {
        username = user.name;
        hostname = host.name or null;
      };
    in
      lib.mkMerge [
        {
          programs.ssh = {
            enable = true;
            enableDefaultConfig = false;

            settings."*" = {
              IdentityFile = "~/${userIdFilePath}";

              IdentitiesOnly = "yes";
              AddKeysToAgent = "yes";
              ForwardAgent = "yes";
            };
          };
        }

        (lib.optionalAttrs (options ? sops) {
          sops.age.sshKeyPaths = [
            "${config.home.homeDirectory}/${userIdFilePath}"
          ];
        })
      ];

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
