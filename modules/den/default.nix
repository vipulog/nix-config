{den, ...}: {
  den = {
    default.includes = [
      den.batteries.inputs'
      den.batteries.self'
      den.aspects.nix
      den.aspects.nixpkgs
      den.aspects.home-manager
      den.aspects.nur
    ];

    migrations.user-host-content.acknowledged = true;
  };
}
