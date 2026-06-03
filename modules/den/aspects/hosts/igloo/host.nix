{
  inputs,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [
      den.aspects.ephemeral-host
      den.aspects.sops-nix
      den.aspects.niri-de
    ];

    nixos = {
      lib,
      config,
      modulesPath,
      ...
    }: let
      diskoMainCfg = config.disko.devices.disk.main;

      nixMountpoint = diskoMainCfg
        .content
        .partitions
        .root
        .content
        .subvolumes
        .nix
        .mountpoint;

      persistentMountpoint = diskoMainCfg
        .content
        .partitions
        .root
        .content
        .subvolumes
        .persistent
        .mountpoint;
    in {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.nixos-hardware.nixosModules.dell-latitude-7490
      ];

      ephemeral-host = {
        enable = true;
        inherit nixMountpoint persistentMountpoint;
      };

      boot = {
        kernelModules = ["kvm-intel"];
        extraModulePackages = [];

        initrd = {
          availableKernelModules = ["xhci_pci" "nvme" "rtsx_pci_sdmmc"];
          kernelModules = [];
          systemd.enable = true;
        };

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;

      preservation.preserve.directories = [
        "/var/lib/systemd"
        "/var/lib/bluetooth"
        "/var/lib/NetworkManager"

        "/var/log"
      ];

      system.stateVersion = "25.11";
    };

    provides = {
      to-users = {
        includes = [
          den.aspects.niri-de
          den.aspects.neovim
        ];
      };

      tux = {
        includes = [den.batteries.primary-user];

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
