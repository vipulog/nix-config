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

    nixos = {
      virtualisation = {
        vmVariant.users.users.vm-user.enable = lib.mkForce true;
        vmVariantWithDisko.users.users.vm-user.enable = lib.mkForce true;
      };
    };

    user = {
      enable = false;
      initialPassword = "1";
    };
  };
}
