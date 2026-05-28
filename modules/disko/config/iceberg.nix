{self, ...}: {
  flake.diskoConfigurations = {
    iceberg = self.diskoLayouts.btrfsImpermanence {
      device = "/dev/sda";
      swap.enable = false;
    };
  };
}
