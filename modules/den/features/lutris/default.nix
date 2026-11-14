{den, ...}: {
  den.aspects.lutris = {
    includes = [den.aspects.gaming];

    os = {pkgs, ...}: {
      environment.systemPackages = [
        (pkgs.lutris.override {steamSupport = false;})
      ];
    };

    homeManager = {pkgs, ...}: {
      programs.lutris = {
        enable = true;

        protonPackages = [pkgs.proton-ge-bin];
        winePackages = [pkgs.wineWow64Packages.stable];
        defaultWinePackage = pkgs.proton-ge-bin;
      };
    };

    persist-user = {
      directories = {
        ".config/lutris".enable = true;
        ".local/share/lutris".enable = true;
        ".cache/lutris".enable = true;
      };
    };
  };
}
