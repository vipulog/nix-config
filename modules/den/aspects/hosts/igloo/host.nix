{
  inputs,
  self,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [den.aspects.niri];

    nixos = {
      lib,
      config,
      modulesPath,
      ...
    }: {
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

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;
    };

    provides.to-users = {
      includes = [den.aspects.niri];
    };
  };
}
