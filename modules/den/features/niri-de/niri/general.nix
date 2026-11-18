{
  den.aspects.niri-de.niri.general = {
    homeManager = {
      wayland.windowManager.niri.extraConfig = ''
        screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"
        prefer-no-csd
        hotkey-overlay { skip-at-startup; }
      '';
    };
  };
}
