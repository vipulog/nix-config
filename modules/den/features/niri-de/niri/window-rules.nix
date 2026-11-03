{
  den.aspects.niri-de.niri.window-rules.configKdl = ''
    window-rule {
        match app-id="^steam$" title="^notificationtoasts_\\d+_desktop$"
        open-focused false
        default-floating-position relative-to="bottom-right" x=10 y=10
    }
  '';
}
