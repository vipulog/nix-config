{
  den,
  lib,
  inputs,
  ...
}: {
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-secrets = {
      url = "github:vipulog/nix-secrets/main";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
  };

  den.aspects.sops-nix = {
    host,
    user,
  }: let
    secretsDir = "${inputs.my-secrets}/secrets/sops";
    isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;

    sshHostKeyPath = "/etc/ssh/id_${host.name}";
    sshUserKeyPath = ".ssh/id_${user.name}";
    sshUserHostKeyPath = ".ssh/id_${user.name}_${host.name}";

    joinPath = segments: let
      trimmed = map (s: lib.removeSuffix "/" (lib.removePrefix "/" s)) segments;
      nonEmpty = builtins.filter (s: s != "") trimmed;
    in
      "/" + lib.concatStringsSep "/" nonEmpty;

    resolveKeyPaths = {
      persistPoint,
      homePath,
    }: {
      sshHostKeyPath =
        if isEphemeralHost
        then joinPath [persistPoint sshHostKeyPath]
        else sshHostKeyPath;

      sshUserKeyPath =
        if isEphemeralHost
        then joinPath [persistPoint homePath sshUserKeyPath]
        else joinPath [homePath sshUserKeyPath];

      sshUserHostKeyPath =
        if isEphemeralHost
        then joinPath [persistPoint homePath sshUserHostKeyPath]
        else joinPath [homePath sshUserHostKeyPath];
    };
  in {
    nixos = {config, ...}: let
      resolved = resolveKeyPaths {
        persistPoint = config.ephemeral-host.persistentMountpoint;
        homePath = config.users.users.${user.name}.home;
      };
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops = {
        defaultSopsFile = "${secretsDir}/${host.name}.yaml";

        age.sshKeyPaths = [
          resolved.sshHostKeyPath
          resolved.sshUserKeyPath
          resolved.sshUserHostKeyPath
        ];
      };

      services.openssh = {
        enable = true;

        hostKeys = [
          {
            path = resolved.sshHostKeyPath;
            type = "ed25519";
          }
        ];
      };
    };

    homeManager = {
      config,
      osConfig,
      ...
    }: let
      resolved = resolveKeyPaths {
        persistPoint = osConfig.ephemeral-host.persistentMountpoint;
        homePath = config.home.homeDirectory;
      };
    in {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops = {
        defaultSopsFile = "${secretsDir}/${user.name}_${host.name}.yaml";

        age.sshKeyPaths = [
          resolved.sshHostKeyPath
          resolved.sshUserKeyPath
          resolved.sshUserHostKeyPath
        ];
      };
    };

    persist = {
      preserve = {
        files = [
          {
            file = sshHostKeyPath;
            how = "symlink";
            configureParent = true;
          }

          {
            file = "${sshHostKeyPath}.pub";
            how = "symlink";
            configureParent = true;
          }
        ];

        users.${user.name}.directories = [
          {
            directory = ".ssh";
            mode = "0700";
          }
        ];
      };
    };
  };
}
