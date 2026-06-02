{self, ...}: {
  den.aspects.iceberg = {
    nixos = {
      virtualisation = {
        vmVariantWithDisko = {
          virtualisation = {
            memorySize = 2048;
            cores = 2;
            graphics = true;

            qemu.options = [
              "-device virtio-vga-gl"
              "-display gtk,gl=on"
            ];
          };
        };
      };
    };

    provides = {
      vm-user = {
        homeManager = {
          home.stateVersion = "25.11";
        };
      };
    };
  };

  perSystem = {pkgs, ...}: let
    host = self.nixosConfigurations.iceberg.config;
    vm = host.system.build.vmWithDisko;
  in {
    packages.iceberg-vm = pkgs.writeShellApplication {
      name = "iceberg-vm";
      text = "${vm}/bin/disko-vm \"$@\"";
    };
  };
}
