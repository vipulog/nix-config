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
    user,
  }: let
    isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;

    sshKeyType = "ed25519";
    sshHostKeyPath = "/etc/ssh/ssh_host_${sshKeyType}_key";
    sshUserKeyPath = ".ssh/id_${sshKeyType}";
  in {
    nixos = {
      lib,
      config,
      host,
      ...
    }: let
      sshHostKeyPath' =
        if isEphemeralHost
        then "${config.ephemeral-host.persistentMountpoint}${sshHostKeyPath}"
        else sshHostKeyPath;
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      config = lib.mkMerge [
        {
          sops = {
            defaultSopsFile = "${inputs.my-secrets}/secrets/sops/${host.name}.yaml";
            age.sshKeyPaths = [sshHostKeyPath'];
          };

          services.openssh = {
            enable = true;

            hostKeys = [
              {
                path = sshHostKeyPath';
                type = sshKeyType;
              }
            ];
          };
        }

        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
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

    homeManager = {
      config,
      host,
      user,
      ...
    }: {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops = {
        defaultSopsFile = "${inputs.my-secrets}/secrets/sops/${user.name}_${host.name}.yaml";

        age.sshKeyPaths = [
          "${config.home.homeDirectory}/${sshUserKeyPath}"
        ];
      };
    };
  };
}
