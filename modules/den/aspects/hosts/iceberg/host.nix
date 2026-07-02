{
  den,
  lib,
  ...
}: {
  den = {
    aspects.iceberg = {
      includes = [
        den.policies.iceberg-to-users
        den.policies.iceberg-to-tux

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
          "/etc/NetworkManager/system-connections"

          "/var/log"
        ];

        system.stateVersion = "26.05";
      };
    };

    policies.iceberg-to-users = {
      host,
      user,
      ...
    }: let
      guard = host.name == "iceberg";
    in
      lib.optional guard (den.lib.policy.include {
        includes = [den.aspects.ephemeral-host];
      });

    policies.iceberg-to-tux = {
      host,
      user,
      ...
    }: let
      guard = host.name == "iceberg" && user.name == "tux";
    in
      lib.optional guard (den.lib.policy.include {
        includes = [
          den.aspects.sops-nix
          den.aspects.niri-de
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
          home.stateVersion = "26.05";
        };
      });
  };
}
