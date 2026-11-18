{
  den.aspects.niri-de.niri.environment = {
    homeManager = {
      wayland.windowManager.niri.extraConfig = ''
        environment {
            "QT_QPA_PLATFORMTHEME" "gtk3"
            "XDG_CURRENT_DESKTOP" "niri"
        }
      '';
    };
  };
}
