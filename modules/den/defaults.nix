{den, ...}: {
  den.default = {
    includes = [
      den.batteries.hostname
      den.batteries.inputs'
      den.batteries.self'

      den.aspects.localization
    ];
  };
}
