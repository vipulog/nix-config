{
  den.aspects.home-manager = {
    os = {pkgs, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupCommand = "${pkgs.trash-cli}/bin/trash-put";
      };
    };

    homeManager = {
      news.display = "silent";
      programs.home-manager.enable = true;
    };
  };
}
