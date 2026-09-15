{inputs, ...}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.aspects.ephemeral-host.preservation = {user}: {
    nixos = {
      lib,
      config,
      options,
      persist,
      ...
    }: let
      hostCfg = config.ephemeral-host;
      cfg = config.preservation;
      inherit (cfg) defaultPreserveAt;
    in {
      imports = [inputs.preservation.nixosModules.default];

      options.preservation = {
        preserve = lib.mkOption {
          type = options.preservation.preserveAt.type.nestedTypes.elemType;
          default = {};
        };

        defaultPreserveAt = lib.mkOption {
          type = lib.types.str;
          default = hostCfg.persistentMountpoint;
        };
      };

      config = lib.mkIf hostCfg.enable {
        preservation = lib.mkMerge (
          [
            {
              enable = true;
              preserve.persistentStoragePath = defaultPreserveAt;

              preserveAt.${defaultPreserveAt} =
                lib.mkAliasDefinitions options.preservation.preserve;
            }
          ]
          ++ persist
        );

        systemd.services.systemd-machine-id-commit = {
          unitConfig.ConditionPathIsMountPoint = [
            ""
            "${defaultPreserveAt}/etc/machine-id"
          ];

          serviceConfig.ExecStart = [
            ""
            "systemd-machine-id-setup --commit --root ${defaultPreserveAt}"
          ];
        };
      };
    };

    persist = {
      preserve = {
        directories = [
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ];

        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
            how = "symlink";
          }
        ];

        users.${user.name} = {
          files = [
            ".config/mimeapps.list"
          ];

          directories = [
            "Documents"
            "Music"
            "Pictures"
            "Videos"
            "Dev"

            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
          ];
        };
      };
    };
  };
}
