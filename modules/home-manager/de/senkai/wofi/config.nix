{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    xdg.configFile."wofi/config".text = ''
      ## General
      show=drun
      prompt=Apps
      term=${pkgs.ghostty}

      ## Geometry
      width=540px
      height=360px
      location=0
      orientation=vertical
      line_wrap=off
      dynamic_lines=false

      ## Images
      allow_markup=true
      allow_images=true
      image_size=24

      ## Search
      exec_search=false
      hide_search=false
      parse_search=false
      insensitive=true

      ## Other
      hide_scroll=true
      no_actions=true
      sort_order=default
      gtk_dark=true
      filter_rate=100

      ## Keys
      key_exit=Escape
    '';
  };
}
