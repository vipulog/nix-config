{
  inputs,
  self,
  den,
  ...
}: {
  den.aspects.igloo = {
    includes = [den.aspects.niri];

    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
        self.diskoConfigurations.igloo
      ];

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    provides.to-users = {
      includes = [den.aspects.niri];
    };
  };
}
