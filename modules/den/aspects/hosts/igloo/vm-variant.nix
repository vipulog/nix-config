{self, ...}: {
  den.aspects.igloo = {
    nixos = {lib, ...}: {
      virtualisation.vmVariantWithDisko = {
        virtualisation = {
          memorySize = 2048;
          cores = 2;
          graphics = true;

          qemu.options = [
            "-device virtio-vga-gl"
            "-display gtk,gl=on"
          ];
        };

        users.users.tux = {
          initialPassword = "tux";
          hashedPasswordFile = lib.mkForce null;
        };
      };
    };
  };

  perSystem = {pkgs, ...}: let
    host = self.nixosConfigurations.igloo.config;
    vm = host.system.build.vmWithDisko;
  in {
    packages.igloo-vm = pkgs.writeShellApplication {
      name = "igloo-vm";
      text = "${vm}/bin/disko-vm \"$@\"";
    };
  };
}
