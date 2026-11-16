{
  inputs,
  self,
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

  den.aspects.sops-nix = let
    inherit (self.lib.den.sops-nix) mkHostSecretsFilePath mkUserSecretsFilePath joinPath;
    inherit (self.lib.den.ssh) mkHostIdFilePath mkUserIdFilePath;
  in {
    nixos = {
      host,
      lib,
      config,
      ...
    }: let
      isEphemeralHost = config.ephemeral-host.enable or false;

      hostIdFilePath = joinPath [
        (lib.optionalString isEphemeralHost config.ephemeral-host.persistentMountpoint)
        (mkHostIdFilePath {hostname = host.name;})
      ];
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops = {
        defaultSopsFile = mkHostSecretsFilePath {hostname = host.name;};
        age.sshKeyPaths = [hostIdFilePath];
      };
    };

    darwin = {host, ...}: {
      imports = [inputs.sops-nix.darwinModules.sops];

      sops = {
        defaultSopsFile = mkHostSecretsFilePath {hostname = host.name;};
        age.sshKeyPaths = [(mkHostIdFilePath {hostname = host.name;})];
      };
    };

    homeManager = {
      user,
      host ? null,
      config,
      ...
    }: {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops = {
        defaultSopsFile = mkUserSecretsFilePath {
          username = user.name;
          hostname = host.name or null;
        };

        age.sshKeyPaths = [
          "${config.home.homeDirectory}/${mkUserIdFilePath {
            username = user.name;
            hostname = host.name or null;
          }}"
        ];
      };
    };
  };
}
