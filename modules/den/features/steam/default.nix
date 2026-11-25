{den, ...}: {
  den.aspects.steam = {
    includes = [
      (den.batteries.unfree ["steam-unwrapped" "steam"])
      den.aspects.gaming
    ];

    nixos = {pkgs, ...}: {
      programs.steam = {
        enable = true;
        extraCompatPackages = [pkgs.proton-ge-bin];

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
      };
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.steam];
    };

    persist-user = {
      directories = {
        ".local/share/Steam".enable = true;
        ".steam".enable = true;
      };
    };
  };
}
