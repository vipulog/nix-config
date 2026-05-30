{
  inputs,
  self,
  den,
  ...
}: {
  den.aspects.iceberg = {
    includes = [
      den.aspects.home-manager
      den.aspects.preservation
      den.aspects.sops-nix
      den.aspects.niri
    ];

    nixos = {
      lib,
      config,
      modulesPath,
      host,
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

      sshHostKeyPath = "${preservationMountpoint}/etc/ssh/ssh_host_ed25519_key";
    in {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")

        inputs.disko.nixosModules.disko
        self.diskoConfigurations.iceberg
      ];

      boot = {
        kernelModules = ["kvm-intel"];
        extraModulePackages = [];

        initrd = {
          systemd.enable = true;
          kernelModules = ["dm-snapshot"];

          availableKernelModules = [
            "ehci_pci"
            "ata_piix"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
        };

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };

      fileSystems = {
        "${nixMountpoint}".neededForBoot = true;
        "${preservationMountpoint}".neededForBoot = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking = {
        useDHCP = lib.mkDefault true;
        networkmanager.enable = true;
      };

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
            {
              file = "/etc/ssh/ssh_host_ed25519_key";
              how = "symlink";
              configureParent = true;
            }
            {
              file = "/etc/ssh/ssh_host_ed25519_key.pub";
              how = "symlink";
              configureParent = true;
            }
          ];
        };
      };

      sops = {
        defaultSopsFile = "${inputs.my-secrets}/secrets/sops/${host.name}.yaml";
        age.sshKeyPaths = [sshHostKeyPath];
      };

      services.openssh = {
        enable = true;

        hostKeys = [
          {
            path = sshHostKeyPath;
            type = "ed25519";
          }
        ];
      };

      users.users.vm-user.enable = false;

      system.stateVersion = "25.11";
    };

    provides = {
      to-users = {
        includes = [
          den.aspects.niri
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
