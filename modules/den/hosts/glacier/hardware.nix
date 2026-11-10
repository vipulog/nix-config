{
  den.aspects.glacier.hardware = {
    nixos = {
      modulesPath,
      lib,
      ...
    }: {
      imports = [(modulesPath + "/profiles/qemu-guest.nix")];

      boot = {
        kernelModules = [];
        extraModulePackages = [];

        initrd = {
          kernelModules = [];

          availableKernelModules = [
            "xhci_pci"
            "virtio_pci"
            "virtio_scsi"
            "usbhid"
          ];
        };
      };

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
  };
}
