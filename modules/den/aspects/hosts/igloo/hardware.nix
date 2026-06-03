{inputs, ...}: {
  den.aspects.igloo = {
    nixos = {
      modulesPath,
      lib,
      config,
      ...
    }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.nixos-hardware.nixosModules.dell-latitude-7490
      ];

      boot = {
        kernelModules = ["kvm-intel"];
        extraModulePackages = [];

        initrd = {
          kernelModules = [];
          systemd.enable = true;

          availableKernelModules = [
            "xhci_pci"
            "nvme"
            "rtsx_pci_sdmmc"
          ];
        };
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
