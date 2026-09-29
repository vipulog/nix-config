{
  den.aspects.home-manager = {user}: {
    os = {pkgs, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupCommand = "${pkgs.trash-cli}/bin/trash-put";
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/state/home-manager"
      ];
    };
  };
}
