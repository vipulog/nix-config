{inputs, ...}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.aspects.preservation = {
    nixos = {
      lib,
      config,
      options,
      ...
    }: let
      cfg = config.preservation;
      inherit (cfg) defaultPreserveAt;

      defaultPreserve = {
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
    in {
      imports = [inputs.preservation.nixosModules.default];

      options.preservation = {
        preserve = lib.mkOption {
          type = options.preservation.preserveAt.type.nestedTypes.elemType;
          default = {};
        };

        defaultPreserveAt = lib.mkOption {
          type = lib.types.str;
          default = "/persistent";
        };
      };

      config.preservation = {
        preserveAt.${defaultPreserveAt} = cfg.preserve;
        preserve = defaultPreserve;
      };
    };
  };
}
