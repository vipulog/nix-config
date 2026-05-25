{lib, ...}: {
  flake.diskoLayouts.impermanence = {
    device,
    imageSize ? "30G",
    swap ? {},
  }: let
    defaultSwap = {
      enable = true;
      size = "4G";
    };

    finalSwap = defaultSwap // swap;
  in {
    fileSystems."/nix".neededForBoot = true;

    disko = {
      imageBuilder.extraRootModules = ["btrfs"];

      devices = {
        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = ["size=25%" "mode=755"];
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
              };

              esp = {
                name = "ESP";
                size = "1G";
                type = "EF00";

                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };

              swap = lib.mkIf finalSwap.enable {
                inherit (finalSwap) size;

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
                    "/persistent" = {
                      mountOptions = ["subvol=persistent" "noatime"];
                      mountpoint = "/persistent";
                    };

                    "/nix" = {
                      mountOptions = ["subvol=nix" "noatime"];
                      mountpoint = "/nix";
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
