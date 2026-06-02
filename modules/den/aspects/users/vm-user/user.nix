{
  lib,
  den,
  ...
}: {
  den.aspects.vm-user = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      (den.batteries.vm-autologin "vm-user")
    ];

    nixos = {options, ...}: {
      virtualisation = lib.mkMerge [
        {vmVariant.users.users.vm-user.enable = lib.mkForce true;}

        (lib.mkIf ((options.disko or null) != null) {
          vmVariantWithDisko.users.users.vm-user.enable = lib.mkForce true;
        })
      ];
    };

    user = {
      enable = false;
      initialPassword = "1";
    };
  };
}
