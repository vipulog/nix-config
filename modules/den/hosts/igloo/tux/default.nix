{den, ...}: {
  den.aspects.igloo.provides.tux = {
    includes = [
      den.aspects.igloo.provides.tux.syncthing
      den.aspects.igloo.provides.tux.restic
    ];

    nixos = {
      sops.secrets.tux-password = {
        neededForUsers = true;
      };

      services.tailscale.extraSetFlags = [
        "--operator=tux"
      ];
    };

    user = {config, ...}: {
      hashedPasswordFile = config.sops.secrets.tux-password.path;
    };

    homeManager = {
      home.stateVersion = "26.05";
    };

    persist-user = {
      directories = [
        "DCIM"
        "Recordings"
      ];
    };
  };
}
