{
  inputs,
  self,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [
      den.aspects.home-manager
      den.aspects.preservation
      den.aspects.niri
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

      preservationMountpoint = diskoMainCfg
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

        inputs.disko.nixosModules.disko
        self.diskoConfigurations.igloo
      ];

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

      fileSystems."${nixMountpoint}".neededForBoot = true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;

      preservation = {
        enable = true;
        defaultPreserveAt = preservationMountpoint;

        preserve = {
          directories = [
            "/var/lib/systemd"
            "/var/lib/bluetooth"
            "/var/lib/NetworkManager"

            "/var/log"
          ];

          files = [
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
          ];
        };
      };

      system.stateVersion = "25.11";
    };

    provides = {
      to-users = {
        includes = [den.aspects.niri];
      };

      tux = {
        includes = [den.batteries.primary-user];

        homeManager = {
          home.stateVersion = "25.11";
        };
      };
    };
  };
}
