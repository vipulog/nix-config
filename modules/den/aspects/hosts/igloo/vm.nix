{
  inputs,
  den,
  ...
}: {
  den.aspects.igloo.includes = [
    (den.batteries.vm-autologin "tux")
  ];

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
