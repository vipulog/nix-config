{
  den,
  lib,
  ...
}: {
  den = {
    aspects.igloo = {
      includes = [
        den.aspects.ephemeral-host
        den.aspects.sops-nix
        den.aspects.niri-de
        den.policies.igloo-to-tux
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
    };

    policies.igloo-to-tux = {
      host,
      user,
      ...
    }: let
      guard = host.name == "igloo" && user.name == "tux";
    in
      lib.optional guard (den.lib.policy.include {
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
      });
  };
}
