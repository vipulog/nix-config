{den, ...}: {
  den.hosts.x86_64-linux.igloo = {
    users.tux = {};
  };

  den.aspects.igloo = {
    includes = [
      den.aspects.igloo.hardware
      den.aspects.igloo.disko
      den.aspects.igloo.snapper
      den.aspects.igloo.niri-de
      den.aspects.ephemeral-host
      den.aspects.sops-nix
      den.aspects.sudo
      den.aspects.bootvine
      den.aspects.tailscale
      den.aspects.sshd
      den.aspects.podman
      den.aspects.neovim
      den.aspects.waydroid
      den.aspects.kdeconnect
      den.aspects.lutris
    ];

    nixos = {config, ...}: {
      boot.loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      hardware.bluetooth.enable = true;
      networking.networkmanager.enable = true;

      ephemeral-host = let
        mainDiskCfg = config.disko.devices.disk.main;
        subVols = mainDiskCfg.content.partitions.root.content.subvolumes;
      in {
        enable = true;
        nixMountpoint = subVols.nix.mountpoint;
        persistentMountpoint = subVols.persistent.mountpoint;
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 50;
        priority = 100;
      };

      system.stateVersion = "26.05";
    };

    persist-host = {
      directories = {
        "/var/lib/bluetooth".enable = true;
        "/etc/NetworkManager/system-connections".enable = true;
      };
    };
  };
}
