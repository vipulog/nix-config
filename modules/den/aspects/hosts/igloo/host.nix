{den, ...}: {
  den.aspects.igloo = {
    includes = [
      den.aspects.ephemeral-host
      den.aspects.sops-nix
      den.aspects.niri-de
    ];

    nixos = {config, ...}: {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      hardware.bluetooth.enable = true;
      networking.networkmanager.enable = true;
      services.blueman.enable = true;

      ephemeral-host = let
        mainDiskCfg = config.disko.devices.disk.main;
        subVols = mainDiskCfg.content.partitions.root.content.subvolumes;
      in {
        enable = true;
        nixMountpoint = subVols.nix.mountpoint;
        persistentMountpoint = subVols.persistent.mountpoint;
      };

      preservation.preserve.directories = [
        "/var/lib/systemd"
        "/var/lib/bluetooth"
        "/var/lib/NetworkManager"

        "/var/log"
      ];

      system.stateVersion = "25.11";
    };

    provides = {
      tux = {
        includes = [
          den.aspects.sops-nix
          den.aspects.niri-de
          den.aspects.neovim
        ];

        nixos = {
          sops.secrets.tux-password = {
            neededForUsers = true;
          };
        };

        user = {config, ...}: {
          hashedPasswordFile = config.sops.secrets.tux-password.path;
        };

        homeManager = {
          home.stateVersion = "25.11";
        };
      };
    };
  };
}
