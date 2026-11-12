{den, ...}: {
  den.aspects.disko.btrfs-impermanence = {
    includes = [den.aspects.disko];

    nixos = {
      config,
      lib,
      ...
    }: let
      cfg = config.disko.btrfs-impermanence;
    in {
      options.disko.btrfs-impermanence = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to enable btrfs-impermanence disk layout.";
        };

        device = lib.mkOption {
          type = lib.types.str;
          description = "Disk device path.";
        };

        tmpfs = {
          size = lib.mkOption {
            type = lib.types.str;
            default = "25%";
            description = "Size of tmpfs root partition.";
          };

          mode = lib.mkOption {
            type = lib.types.str;
            default = "755";
            description = "Mount mode for tmpfs root.";
          };
        };

        swap = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to create a swap partition.";
          };

          size = lib.mkOption {
            type = lib.types.str;
            default = "8G";
            description = "Size of swap partition.";
          };

          resumeDevice = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to use swap partition as resume device.";
          };
        };

        snapshots = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to create .snapshots subvolume under persistent storage.";
        };

        imageSize = lib.mkOption {
          type = lib.types.str;
          default = "30G";
          description = "Disk image size for imageBuilder.";
        };

        persistMp = lib.mkOption {
          type = lib.types.str;
          default = config.ephemeral-host.persistMp or "/persistent";
          description = "Mountpoint for persistent data.";
        };

        nixMp = lib.mkOption {
          type = lib.types.str;
          default = config.ephemeral-host.nixMp or "/nix";
          description = "Mountpoint for the nix store.";
        };
      };

      config = lib.mkIf cfg.enable {
        disko = {
          imageBuilder.extraRootModules = ["btrfs"];

          devices = {
            nodev."/" = {
              fsType = "tmpfs";
              mountOptions = ["size=${cfg.tmpfs.size}" "mode=${cfg.tmpfs.mode}"];
            };

            disk.main = {
              inherit (cfg) device imageSize;
              type = "disk";

              content = {
                type = "gpt";

                partitions = lib.mkMerge [
                  {
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

                    root = {
                      name = "root";
                      size = "100%";

                      content = {
                        type = "btrfs";
                        extraArgs = ["-f"];

                        subvolumes = lib.mkMerge [
                          {
                            persistent = {
                              mountpoint = cfg.persistMp;
                              mountOptions = ["compress=zstd" "noatime"];
                            };

                            nix = {
                              mountpoint = cfg.nixMp;
                              mountOptions = ["compress=zstd" "noatime"];
                            };
                          }

                          (lib.optionalAttrs cfg.snapshots {
                            "persistent/.snapshots" = {};
                          })
                        ];
                      };
                    };
                  }

                  (lib.optionalAttrs cfg.swap.enable {
                    swap = {
                      inherit (cfg.swap) size;

                      content = {
                        type = "swap";
                        inherit (cfg.swap) resumeDevice;
                      };
                    };
                  })
                ];
              };
            };
          };
        };
      };
    };
  };
}
