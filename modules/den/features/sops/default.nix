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
  };

  den.aspects.sops-nix = let
    inherit (self.lib.den.ssh) mkHostIdFilePath mkUserIdFilePath;

    mkHostSecretsFilePath = {
      secretsDir,
      hostname,
    }: "${secretsDir}/${hostname}.yaml";

    mkUserSecretsFilePath = {
      secretsDir,
      username,
      hostname ? null,
    }: let
      name =
        if hostname == null
        then username
        else "${username}_${hostname}";
    in "${secretsDir}/${name}.yaml";

    sharedModule = {
      config,
      lib,
      ...
    }: {
      options.sops-nix = {
        secretsDir = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;

          description = ''
            Base directory used to derive `sops.defaultSopsFile` (via `lib.mkDefault`) when non-null:
            `<secretsDir>/<host>.yaml` on NixOS/Darwin, `<secretsDir>/<user>_<host>.yaml` for hosted
            Home Manager, and `<secretsDir>/<user>.yaml` for standalone Home Manager.
          '';
        };

        sharedSopsFile = lib.mkOption {
          type = lib.types.path;
          default = config.sops.defaultSopsFile;
          defaultText = lib.literalExpression "config.sops.defaultSopsFile";

          description = ''
            Sops file for secrets shared across hosts and users (consumed by cross-cutting
            aspects such as `mcp`). Defaults to `config.sops.defaultSopsFile` when not overridden.
          '';
        };
      };
    };
  in {
    nixos = {
      host,
      lib,
      config,
      ...
    }: let
      cfg = config.sops-nix;
      isEphemeralHost = config.ephemeral-host.enable or false;

      joinPath = segs: let
        clean = builtins.filter (s: s != null) segs;
        trimmed = map (s: lib.removeSuffix "/" (lib.removePrefix "/" s)) clean;
        nonEmpty = builtins.filter (s: s != "") trimmed;
      in
        "/" + lib.concatStringsSep "/" nonEmpty;

      hostIdFilePath = joinPath [
        (lib.optionalString isEphemeralHost config.ephemeral-host.persistMp)
        (mkHostIdFilePath {hostname = host.name;})
      ];
    in {
      imports = [
        inputs.sops-nix.nixosModules.sops
        sharedModule
      ];

      sops = lib.mkMerge [
        {
          age.sshKeyPaths = [hostIdFilePath];
        }

        (lib.mkIf (cfg.secretsDir != null) {
          defaultSopsFile = lib.mkDefault (mkHostSecretsFilePath {
            inherit (cfg) secretsDir;
            hostname = host.name;
          });
        })
      ];
    };

    darwin = {
      host,
      lib,
      config,
      ...
    }: let
      cfg = config.sops-nix;
    in {
      imports = [
        inputs.sops-nix.darwinModules.sops
        sharedModule
      ];

      sops = lib.mkMerge [
        {
          age.sshKeyPaths = [(mkHostIdFilePath {hostname = host.name;})];
        }

        (lib.mkIf (cfg.secretsDir != null) {
          defaultSopsFile = lib.mkDefault (mkHostSecretsFilePath {
            inherit (cfg) secretsDir;
            hostname = host.name;
          });
        })
      ];
    };

    homeManager = {
      user,
      host ? null,
      lib,
      config,
      ...
    }: let
      cfg = config.sops-nix;
    in {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
        sharedModule
      ];

      sops = lib.mkMerge [
        {
          age.sshKeyPaths = [
            "${config.home.homeDirectory}/${mkUserIdFilePath {
              username = user.name;
              hostname = host.name or null;
            }}"
          ];
        }

        (lib.mkIf (cfg.secretsDir != null) {
          defaultSopsFile = lib.mkDefault (mkUserSecretsFilePath {
            inherit (cfg) secretsDir;
            username = user.name;
            hostname = host.name or null;
          });
        })
      ];
    };
  };
}
