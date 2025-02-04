{
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "/home/vipul/Pictures/Wallpapers/";
        sorting = "random";
        duration = "10m";
        transition-time = 3000;
        transition.linear-blur = {
          intensity = "0.5";
        };
      };
    };
  };
}
