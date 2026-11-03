{
  den.aspects.niri-de.dms.greeter = {
    nixos = {
      services.displayManager.dux-greeter = {
        enable = true;
        compositor.name = "niri";
      };
    };
  };
}
