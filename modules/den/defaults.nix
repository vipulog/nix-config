{
  lib,
  den,
  ...
}: {
  den = {
    default = {
      includes = [
        den.batteries.hostname
        den.batteries.inputs'
        den.batteries.self'

        den.aspects.home-manager
        den.aspects.localization
      ];
    };

    schema.user.classes = lib.mkDefault ["homeManager"];
  };
}
