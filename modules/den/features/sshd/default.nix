{
  den.aspects.sshd = let
    mkHostIdFilePath = {hostname}: "/etc/ssh/host_${hostname}";
  in {
    os = {
      host,
      lib,
      config,
      options,
      ...
    }: let
      hostIdFilePath = mkHostIdFilePath {hostname = host.name;};
      isEphemeralHost = config.ephemeral-host.enable or false;

      joinPath = segs: let
        clean = builtins.filter (s: s != null) segs;
        trimmed = map (s: lib.removeSuffix "/" (lib.removePrefix "/" s)) clean;
        nonEmpty = builtins.filter (s: s != "") trimmed;
      in
        "/" + lib.concatStringsSep "/" nonEmpty;

      sopsHostIdFilePath = joinPath [
        (lib.optionalString isEphemeralHost config.ephemeral-host.persistMp)
        hostIdFilePath
      ];
    in
      lib.mkMerge [
        {
          services.openssh = {
            enable = true;

            hostKeys = [
              {
                path = hostIdFilePath;
                type = "ed25519";
              }
            ];
          };
        }

        (lib.optionalAttrs (options ? sops) {
          sops.age.sshKeyPaths = [sopsHostIdFilePath];
        })
      ];

    nixos = {
      services.openssh.settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    darwin = {
      services.openssh.extraConfig = ''
        PermitRootLogin prohibit-password
        PasswordAuthentication no
      '';
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.openssh];
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
  };
}
