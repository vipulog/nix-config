{
  den.aspects.ephemeral-host = {
    nixos = {
      lib,
      config,
      ...
    }: let
      cfg = config.ephemeral-host;
    in {
      options.ephemeral-host = {
        enable = lib.mkEnableOption "ephemeral host";

        nixMountpoint = lib.mkOption {
          type = lib.types.str;
          description = "Mountpoint for the nix store.";
        };

        persistentMountpoint = lib.mkOption {
          type = lib.types.str;
          description = "Mountpoint for the persistent data.";
        };
      };

      config = lib.mkIf cfg.enable {
        fileSystems = {
          "${cfg.nixMountpoint}".neededForBoot = true;
          "${cfg.persistentMountpoint}".neededForBoot = true;
        };
      };
    };
  };
}
