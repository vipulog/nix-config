{
  inputs,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [
      den.aspects.preservation
      den.aspects.sops-nix
      den.aspects.niri-de
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
        inputs.nixos-hardware.nixosModules.dell-latitude-7490
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

      fileSystems = {
        "${nixMountpoint}".neededForBoot = true;
        "${preservationMountpoint}".neededForBoot = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;

      preservation = {
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
