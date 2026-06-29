{
  inputs,
  den,
  ...
}: {
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-secrets = {
      url = "github:vipulog/nix-secrets/main?shallow=1";

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
    user ? null,
    ...
  }: {
    nixos = {
      lib,
      config,
      ...
    }: let
      sshHostKeyType = "ed25519";
      sshHostKeyRelPath = "/etc/ssh/ssh_host_${sshHostKeyType}_key";

      isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;

      persistentMountpoint =
        if isEphemeralHost
        then config.ephemeral-host.persistentMountpoint
        else null;

      sshHostKeyPersistPath =
        if isEphemeralHost
        then "${persistentMountpoint}${sshHostKeyRelPath}"
        else null;

      sshHostKeyPath =
        if isEphemeralHost
        then sshHostKeyPersistPath
        else sshHostKeyRelPath;
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      config = lib.mkMerge [
        {
          sops = {
            defaultSopsFile = "${inputs.my-secrets}/secrets/sops/${host.name}.yaml";
            age.sshKeyPaths = [sshHostKeyPath];
          };

          services.openssh = {
            enable = true;

            hostKeys = [
              {
                path = sshHostKeyPath;
                type = sshHostKeyType;
              }
            ];
          };
        }

        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
            files = [
              {
                file = sshHostKeyRelPath;
                how = "symlink";
                configureParent = true;
              }

              {
                file = "${sshHostKeyRelPath}.pub";
                how = "symlink";
                configureParent = true;
              }
            ];

            users = lib.mkIf (user != null) {
              ${user.name}.directories = [
                {
                  directory = ".ssh";
                  mode = "0700";
                }
              ];
            };
          };
        })
      ];
    };

    darwin = {
      imports = [inputs.sops-nix.darwinModules.sops];
    };

    homeManager = {config, ...}: let
      sshUserKeyType = "ed25519";
      sshUserKeyRelPath = ".ssh/id_${sshUserKeyType}";
    in {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops = {
        defaultSopsFile = "${inputs.my-secrets}/secrets/sops/${user.name}_${host.name}.yaml";

        age.sshKeyPaths = [
          "${config.home.homeDirectory}/${sshUserKeyRelPath}"
        ];
      };
    };
  };
}
