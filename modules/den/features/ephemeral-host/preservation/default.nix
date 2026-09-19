{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.aspects.ephemeral-host.preservation = {
    includes = with den.aspects.ephemeral-host.preservation; [
      persist-host
      persist-user
    ];

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

      config = lib.mkIf hostCfg.enable {
        preservation = {
          enable = true;
          preserve.persistentStoragePath = defaultPreserveAt;

          preserveAt.${defaultPreserveAt} =
            lib.mkAliasDefinitions options.preservation.preserve;
        };
      };
    };
  };
}
