{
  den.aspects.igloo = {
    nixos = {
      disko = {
        imageBuilder.extraRootModules = ["btrfs"];

        devices = {
          nodev."/" = {
            fsType = "tmpfs";
            mountOptions = ["size=25%" "mode=755"];
          };

          disk.main = {
            device = "/dev/nvme0n1";
            imageSize = "30G";
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
                  size = "1G";
                  type = "EF00";
                  priority = 2;

                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = ["umask=0077"];
                  };
                };

                swap = {
                  size = "8G";

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

                    subvolumes = {
                      persistent = {
                        mountpoint = "/persistent";
                        mountOptions = ["compress=zstd" "noatime"];
                      };

                      nix = {
                        mountpoint = "/nix";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
