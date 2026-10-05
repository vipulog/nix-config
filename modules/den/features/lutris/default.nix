{den, ...}: {
  den.aspects.lutris = {
    includes = [den.aspects.gaming];

    homeManager = {pkgs, ...}: {
      programs.lutris = {
        enable = true;

        protonPackages = [pkgs.proton-ge-bin];
        winePackages = [pkgs.wineWow64Packages.stable];
        defaultWinePackage = pkgs.proton-ge-bin;

        extraPackages = with pkgs; [
          winetricks
          umu-launcher
          gamescope
          gamemode
          mangohud
        ];
      };
    };

    persist-user = {
      directories = [
        ".config/lutris"
        ".local/share/lutris"
      ];
    };
  };
}
