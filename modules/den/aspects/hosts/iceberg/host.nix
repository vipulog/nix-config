{den, ...}: {
  den.aspects.iceberg = {
    includes = [
      den.aspects.ephemeral-host
      den.aspects.sops-nix
      den.aspects.niri-de
    ];

    nixos = {
      lib,
      config,
      ...
    }: {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      networking = {
        useDHCP = lib.mkDefault true;
        networkmanager.enable = true;
      };

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
          den.aspects.atuin
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
