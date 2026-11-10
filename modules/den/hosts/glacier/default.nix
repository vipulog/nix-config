{den, ...}: {
  den.hosts.aarch64-linux.glacier = {
    channel = "stable";

    users.root = {
      classes = ["user"];
    };
  };

  den.aspects.glacier = {
    includes = [
      den.aspects.glacier.hardware
      den.aspects.ephemeral-host
      den.aspects.disko.btrfs-impermanence
      den.aspects.sops-nix
      den.aspects.sshd
      den.aspects.tailscale
      den.aspects.glacier.reverse-proxy
      den.aspects.glacier.homepage
      den.aspects.glacier.vaultwarden
      den.aspects.glacier.immich
      den.aspects.glacier.paperless
      den.aspects.glacier.ntfy
      den.aspects.glacier.uptime-kuma
      den.aspects.glacier.beszel
    ];

    excludes = [
      den.aspects.home-manager
      den.aspects.nur
    ];

    nixos = {
      boot = {
        kernelParams = [
          "console=tty1"
          "console=ttyAMA0,115200"
        ];

        loader = {
          efi.canTouchEfiVariables = true;

          systemd-boot = {
            enable = true;
            configurationLimit = 10;
          };
        };
      };

      fileSystems."/srv" = {
        device = "/dev/disk/by-label/srv";
        fsType = "btrfs";
        options = ["defaults" "noatime"];
      };

      networking = {
        useDHCP = true;
        firewall.trustedInterfaces = ["tailscale0"];
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 50;
        priority = 100;
      };

      disko.btrfs-impermanence.device = "/dev/sda";
      sops.secrets.root-password.neededForUsers = true;
      services.tailscale.extraSetFlags = ["--operator=root"];

      system.stateVersion = "26.05";
    };

    persist-host = {
      directories = {
        "/var/log".enable = true;
      };
    };
  };
}
