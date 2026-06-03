{
  den.aspects.iceberg = {
    nixos = {
      modulesPath,
      lib,
      config,
      ...
    }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
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
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
