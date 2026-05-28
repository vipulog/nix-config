{
  lib,
  self,
  den,
  ...
}: {
  den.aspects.iceberg = {
    includes = [(den.batteries.vm-autologin "vm-user")];

    nixos = {
      virtualisation = {
        vmVariantWithDisko = {
          users.users.vm-user.enable = lib.mkForce true;

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
        includes = [den.batteries.primary-user];

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
