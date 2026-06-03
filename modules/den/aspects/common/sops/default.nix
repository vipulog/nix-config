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

  den.aspects.sops-nix = let
    inherit (den) aspects;
    inherit (den.lib) policy;

    sshHostKeyType = "ed25519";
    sshHostKeyRelPath = "/etc/ssh/ssh_host_${sshHostKeyType}_key";
  in {
    includes = [
      (policy.when ({host, ...}: !(host.hasAspect aspects.ephemeral-host)) {
        nixos = {
          sops.age.sshKeyPaths = [sshHostKeyRelPath];

          services.openssh.hostKeys = [
            {
              path = sshHostKeyRelPath;
              type = sshHostKeyType;
            }
          ];
        };
      })

      (policy.when ({host, ...}: host.hasAspect aspects.ephemeral-host) {
        nixos = {config, ...}: let
          persistentMountpoint = config.ephemeral-host.persistentMountpoint;
          sshHostKeyPath = "${persistentMountpoint}${sshHostKeyRelPath}";
        in {
          sops.age.sshKeyPaths = [sshHostKeyPath];

          services.openssh.hostKeys = [
            {
              path = sshHostKeyPath;
              type = sshHostKeyType;
            }
          ];

          preservation.preserve.files = [
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
        };
      })
    ];

    nixos = {host, ...}: {
      imports = [inputs.sops-nix.nixosModules.sops];
      sops.defaultSopsFile = "${inputs.my-secrets}/secrets/sops/${host.name}.yaml";
      services.openssh.enable = true;
    };

    darwin = {
      imports = [inputs.sops-nix.darwinModules.sops];
    };

    homeManager = {
      imports = [inputs.sops-nix.homeManagerModules.sops];
    };
  };
}
