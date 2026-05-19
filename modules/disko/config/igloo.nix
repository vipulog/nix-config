{self, ...}: {
  flake.diskoConfigurations = {
    igloo = self.diskoLayouts.impermanence {
      device = "/dev/nvme0n1";

      swap = {
        enable = true;
        size = "8G";
      };
    };
  };
}
