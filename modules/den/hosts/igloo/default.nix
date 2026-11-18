{den, ...}: {
  den.hosts.x86_64-linux.igloo = {
    users.tux = {};
  };

  den.aspects.igloo = {
    includes = [
      den.aspects.igloo.hardware
      den.aspects.ephemeral-host
      den.aspects.disko.btrfs-impermanence
      den.aspects.igloo.snapper
      den.aspects.bootvine
      den.aspects.sops-nix
      den.aspects.sudo
      den.aspects.sshd
      den.aspects.tailscale
      den.aspects.niri-de
      den.aspects.podman
      den.aspects.waydroid
      den.aspects.kdeconnect
      den.aspects.lutris
      den.aspects.neovim
    ];

    nixos = {
      boot.loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      hardware.bluetooth.enable = true;
      networking.networkmanager.enable = true;

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 50;
        priority = 100;
      };

      disko.btrfs-impermanence = {
        device = "/dev/nvme0n1";
        swap.enable = true;
        snapshots = true;
      };

      services.displayManager = {
        autoLogin = {
          enable = true;
          user = "tux";
        };

        dux-greeter = {
          configHome = "/home/tux";
        };
      };

      sops.secrets.tux-password.neededForUsers = true;
      services.tailscale.extraSetFlags = ["--operator=tux"];

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
