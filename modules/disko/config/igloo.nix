{self, ...}: {
  flake.diskoConfigurations.igloo = self.diskoLayouts.btrfsImpermanence {
    device = "/dev/nvme0n1";

    swap = {
      enable = true;
      size = "8G";
    };
  };
}
