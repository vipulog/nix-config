{lib, ...}: {
  flake.diskoLayouts.btrfsImpermanence = {
    device,
    tmpfsSize ? "25%",
    tmpfsMode ? "755",
    imageSize ? "30G",
    espSize ? "1G",
    swap ? {
      enable = true;
      size = "4G";
    },
    subvolumes ? {
      persistent = {
        mountpoint = "/persistent";
        mountOptions = ["compress=zstd" "noatime"];
      };
      nix = {
        mountpoint = "/nix";
        mountOptions = ["compress=zstd" "noatime"];
      };
    },
  }: {
    disko = {
      imageBuilder.extraRootModules = ["btrfs"];

      devices = {
        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = ["size=${tmpfsSize}" "mode=${tmpfsMode}"];
        };

        disk.main = {
          inherit device imageSize;
          type = "disk";

          content = {
            type = "gpt";

            partitions = {
              boot = {
                name = "boot";
                size = "1M";
                type = "EF02";
                priority = 1;
              };

              esp = {
                name = "ESP";
                size = espSize;
                type = "EF00";
                priority = 2;

                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };

              swap = lib.mkIf swap.enable {
                inherit (swap) size;

                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };

              root = {
                name = "root";
                size = "100%";

                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  inherit subvolumes;
                };
              };
            };
          };
        };
      };
    };
  };
}
