{
  lib,
  den,
  ...
}: {
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
      den.batteries.inputs'
      den.batteries.self'

      den.aspects.home-manager
      den.aspects.localization
    ];

    nixos.system.stateVersion = "25.11";
    homeManager.home.stateVersion = "25.11";
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
