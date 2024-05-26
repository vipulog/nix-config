{
  lib,
  config,
  namespace,
  ...
}: let
  diskoCfg = config.${namespace}.misc.disko;
  presetCfg = diskoCfg.presets.single-disk-ext4;
in {
  options.${namespace}.misc.disko.presets.single-disk-ext4 = {
    enable = lib.mkEnableOption ''
      the `single-disk-ext4` preset, which configures a simple disk layout with a
      single ext4 partition for the root filesystem and a boot partition.
    '';

    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/sda";
      description = ''
        The block device to be partitioned and formatted according to the
        `single-disk-ext4` layout, e.g. `/dev/sda` or `/dev/nvme0n1`.
      '';
    };
  };

  config = lib.mkIf (diskoCfg.enable && presetCfg.enable) {
    disko.devices.disk.main = {
      inherit (presetCfg) device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
