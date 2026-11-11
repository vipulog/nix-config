{den, ...}: {
  den.aspects.lutris = {
    includes = [den.aspects.gaming];

    homeManager = {pkgs, ...}: {
      programs.lutris = {
        enable = true;

        protonPackages = [pkgs.proton-ge-bin];
        winePackages = [pkgs.wineWow64Packages.stable];
        defaultWinePackage = pkgs.proton-ge-bin;
      };
    };

    persist-user = {
      directories = [
        ".config/lutris"
        ".local/share/lutris"
        ".cache/lutris"
      ];
    };
  };
}
