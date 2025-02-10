{
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "/home/vipul/Pictures/Wallpapers/";
        sorting = "random";
        duration = "10m";
        transition-time = 3000;
        transition.colour-distance = {
          power = 1000;
        };
      };
    };
  };
}
