{
  den.aspects.igloo = {
    nixos = {
      boot.loader.grub.enable = false;

      fileSystems."/" = {
        device = "/dev/fake";
        fsType = "auto";
      };
    };
  };
}
