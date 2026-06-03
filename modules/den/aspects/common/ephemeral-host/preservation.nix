{inputs, ...}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.aspects.ephemeral-host = {
    nixos = {
      lib,
      config,
      options,
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

      config.preservation = lib.mkIf hostCfg.enable {
        enable = true;
        preserveAt.${defaultPreserveAt} = cfg.preserve;

        preserve = {
          persistentStoragePath = defaultPreserveAt;

          directories = [
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }

            "/etc/nixos"
          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];
        };
      };
    };
  };
}
