{
  self,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [(den.batteries.vm-autologin "tux")];

    nixos = {
      virtualisation = {
        vmVariant = {
          virtualisation = {
            memorySize = 2048;
            cores = 2;
            diskSize = 20480;
            graphics = true;

            qemu.options = [
              "-device virtio-vga-gl"
              "-display gtk,gl=on"
            ];
          };
        };
      };
    };
  };

  perSystem = {pkgs, ...}: let
    host = self.nixosConfigurations.igloo.config;
    hostname = host.networking.hostName;
    vm = host.system.build.vm;
  in {
    packages.igloo-vm = pkgs.writeShellApplication {
      name = "igloo-vm";
      text = "${vm}/bin/run-${hostname}-vm \"$@\"";
    };
  };
}
