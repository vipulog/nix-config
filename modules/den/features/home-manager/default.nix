{
  den.aspects.home-manager = {
    os = {pkgs, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupCommand = "${pkgs.trash-cli}/bin/trash-put";
      };
    };

    persist-user = {
      directories = [
        ".local/state/home-manager"
      ];
    };
  };
}
