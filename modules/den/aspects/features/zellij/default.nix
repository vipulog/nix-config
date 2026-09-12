{
  den.aspects.zellij = {user}: {
    homeManager = {
      config,
      osConfig,
      pkgs,
      ...
    }: let
      tz = osConfig.time.timeZone or "UTC";
    in {
      programs.zellij = {
        enable = true;

        layouts.default = ''
          layout {
            pane split_direction="vertical" {
              pane
            }

            pane size=1 borderless=true {
              plugin location="file:${pkgs.zellijPlugins.zjstatus}" {
                hide_frame_for_single_pane "true"

                format_left  "{mode}#[fg=#89B4FA,bg=#181825,bold] {session}#[bg=#181825] {tabs}"
                format_right "{datetime}"
                format_space "#[bg=#181825]"

                mode_normal          "#[bg=#89B4FA] "
                mode_tmux            "#[bg=#ffc387] "
                mode_default_to_mode "tmux"

                tab_normal   "#[fg=#6C7086,bg=#181825] {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                tab_active   "#[fg=#9399B2,bg=#181825,bold,italic] {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                tab_fullscreen_indicator "□ "
                tab_sync_indicator       " "
                tab_floating_indicator   "󰉈 "

                datetime          "#[fg=#9399B2,bg=#181825] {format} "
                datetime_format   "%A, %d %b %Y %H:%M"
                datetime_timezone "${tz}"
              }
            }
          }
        '';
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/zellij"
        ".cache/zellij"
      ];
    };
  };
}
