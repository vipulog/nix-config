{
  den.aspects.niri-de.niri.layer-rules = {
    homeManager = {
      wayland.windowManager.niri.extraConfig = ''
        layer-rule {
            match namespace="^quickshell$"
            place-within-backdrop true
        }
      '';
    };
  };
}
