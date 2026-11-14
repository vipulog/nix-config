{
  den.aspects.home-manager = {
    os = {pkgs, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupCommand = "${pkgs.trash-cli}/bin/trash-put";
      };
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.home-manager];
    };

    persist-user = {
      directories = {
        ".local/state/home-manager".enable = true;
      };
    };
  };
}
