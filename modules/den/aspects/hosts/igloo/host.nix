{den, ...}: {
  den.aspects.igloo = {
    includes = [den.aspects.niri];

    nixos = {
      boot.loader.grub.enable = false;

      fileSystems."/" = {
        device = "/dev/fake";
        fsType = "auto";
      };
    };

    provides.to-users = {
      includes = [den.aspects.niri];
    };
  };
}
