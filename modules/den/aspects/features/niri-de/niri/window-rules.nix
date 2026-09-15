{
  den.aspects.niri-de.niri.window-rules.configKdl = ''
    window-rule {
        draw-border-with-background false
        geometry-corner-radius 6 6 6 6
        clip-to-geometry true
        tiled-state true
    }

    window-rule {
        match app-id="^gnome-calculator$"
        match app-id="^galculator$"
        match app-id="^blueman-manager$"
        match app-id="^org\\.gnome\\.Nautilus$"
        match app-id="^xdg-desktop-portal$"
        match app-id="zoom"
        match app-id="org.quickshell$"
        match app-id="com.danklinux.dms$"
        match app-id="firefox$" title="^Picture-in-Picture$"
        open-floating true
    }

    window-rule {
        match app-id="^steam$" title="^notificationtoasts_\\d+_desktop$"
        open-focused false
        default-floating-position relative-to="bottom-right" x=10 y=10
    }

    window-rule {
        match app-id="Alacritty" at-startup=true
        open-on-workspace "1-dev"
        open-focused false
        open-maximized true
    }

    window-rule {
        match app-id="firefox$" at-startup=true
        open-on-workspace "2-web"
        open-focused false
        open-maximized true
    }

    window-rule {
        match app-id="Alacritty"
        background-effect { blur true; }
    }
  '';
}
