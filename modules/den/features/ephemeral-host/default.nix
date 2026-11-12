{
  den,
  lib,
  inputs,
  self,
  ...
}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den = {
    classes = {
      persist-host.description = "Host-level persist module.";
      persist-user.description = "User-level persist module.";
    };

    policies = let
      inherit (den.lib) policy;
    in {
      persist-host = {host, ...}:
        lib.optional (host ? class) (
          policy.route {
            fromClass = "persist-host";
            intoClass = host.class;
            path = ["ephemeral-host" "persist-host"];
            guard = {options, ...}: options ? ephemeral-host;
          }
        );

      persist-user = {
        host,
        user,
        home ? null,
        ...
      }:
        lib.optional (host ? class && home == null) (
          policy.route {
            fromClass = "persist-user";
            intoClass = host.class;
            path = ["ephemeral-host" "persist-users" user.name];
            receiver = host;
            guard = {options, ...}: options ? ephemeral-host;
          }
        );
    };

    aspects.ephemeral-host = {
      includes = [den.aspects.ephemeral-host.persist-defaults];

      nixos = {
        lib,
        options,
        config,
        ...
      }: let
        cfg = config.ephemeral-host;
        inherit (self.lib.den.ephemeral-host) mkPersistSubmodule persistToPreservation;
        persistSubmodule = mkPersistSubmodule {inherit options;};
      in {
        imports = [inputs.preservation.nixosModules.default];

        options.ephemeral-host = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to enable ephemeral host.";
          };

          nixMp = lib.mkOption {
            type = lib.types.str;
            default = "/nix";
            description = "Mountpoint for the nix store.";
          };

          persistMp = lib.mkOption {
            type = lib.types.str;
            default = "/persistent";
            description = "Mountpoint for the persistent data.";
          };

          persist-host = lib.mkOption {
            type = persistSubmodule;
            default = {};
            description = "Host-level persist definitions.";
          };

          persist-users = lib.mkOption {
            type = lib.types.attrsOf persistSubmodule;
            default = {};
            description = "User-level persist definitions.";
          };
        };

        config = lib.mkIf cfg.enable {
          fileSystems = {
            "${cfg.nixMp}".neededForBoot = true;
            "${cfg.persistMp}".neededForBoot = true;
          };

          preservation = {
            enable = true;

            preserveAt.${cfg.persistMp} = {
              files = persistToPreservation cfg.persist-host.files;
              directories = persistToPreservation cfg.persist-host.directories;

              users =
                lib.mapAttrs (_username: userPersist: {
                  files = persistToPreservation userPersist.files;
                  directories = persistToPreservation userPersist.directories;
                })
                cfg.persist-users;
            };
          };
        };
      };

      persist-defaults = {
        nixos = {config, ...}: let
          inherit (config.ephemeral-host) persistMp;
        in {
          boot.initrd.systemd.tmpfiles.settings.preservation."/sysroot/state/etc/machine-id".f = {
            argument = "uninitialized";
          };

          systemd.services.systemd-machine-id-commit = {
            unitConfig.ConditionPathIsMountPoint = [
              ""
              "${persistMp}/etc/machine-id"
            ];

            serviceConfig.ExecStart = [
              ""
              "systemd-machine-id-setup --commit --root ${persistMp}"
            ];
          };
        };

        persist-host = {
          directories = {
            "/var/lib/nixos" = {
              enable = true;
              inInitrd = true;
            };
          };

          files = {
            "/etc/machine-id" = {
              enable = true;
              inInitrd = true;
              how = "symlink";
              configureParent = true;
            };
          };
        };

        persist-user = {
          files = {
            ".config/mimeapps.list".enable = true;
          };

          directories = {
            "Documents".enable = true;
            "Music".enable = true;
            "Pictures".enable = true;
            "Videos".enable = true;
            "Dev".enable = true;

            ".local/share/keyrings" = {
              enable = true;
              mode = "0700";
            };
          };
        };
      };
    };
  };
}
