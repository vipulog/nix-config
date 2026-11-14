{den, ...}: {
  den = {
    default.includes = [
      den.batteries.inputs'
      den.batteries.self'
      den.aspects.nix
      den.aspects.home-manager
    ];

    migrations.user-host-content.acknowledged = true;
  };
}
