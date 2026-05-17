{
  inputs,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [(den.batteries.vm-autologin "tux")];

    nixos = {pkgs, ...}: {
      hardware.graphics.enable = true;

      virtualisation.vmVariant.virtualisation = {
        graphics = true;

        qemu.options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
        ];
      };

      environment.systemPackages = with pkgs; [
        mesa-demos
      ];
    };
  };

  perSystem = {pkgs, ...}: let
    host = inputs.self.nixosConfigurations.igloo.config;
    hostname = host.networking.hostName;
    vm = host.system.build.vm;
  in {
    packages.igloo-vm = pkgs.writeShellApplication {
      name = "igloo-vm";
      text = "${vm}/bin/run-${hostname}-vm \"$@\"";
    };
  };
}
