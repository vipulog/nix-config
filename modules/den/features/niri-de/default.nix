{den, ...}: {
  den.aspects.niri-de = {
    includes = with den.aspects.niri-de; [
      niri
      dms
      gtk
      thunar
    ];

    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.xwayland-satellite
        pkgs.wl-clipboard
      ];
    };
  };
}
