{
  den.aspects.zellij = {user}: {
    homeManager = {
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

                format_left  "{mode}#[fg=#89B4FA,bold] {session} {tabs}"
                format_right "{command_git_branch}{datetime}"
                format_space ""

                mode_normal       "#[bold] ZELLIJ "
                mode_locked       "#[fg=#f38ba8,bold] LOCKED "
                mode_pane         "#[fg=#a6e3a1,bold] PANE "
                mode_tab          "#[fg=#cba6f7,bold] TAB "
                mode_resize       "#[fg=#fab387,bold] RESIZE "
                mode_scroll       "#[fg=#89dceb,bold] SCROLL "
                mode_search       "#[fg=#f9e2af,bold] SEARCH "
                mode_enter_search "#[fg=#f9e2af,bold] SEARCH "
                mode_rename_tab   "#[fg=#eba0ac,bold] RENAME TAB "
                mode_rename_pane  "#[fg=#eba0ac,bold] RENAME PANE "
                mode_session      "#[fg=#94e2d5,bold] SESSION "
                mode_move         "#[fg=#b4befe,bold] MOVE "
                mode_prompt       "#[fg=#f2cdcd,bold] PROMPT "
                mode_tmux         "#[fg=#f5c2e7,bold] TMUX "

                tab_normal   "#[fg=#6C7086] {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                tab_active   "#[fg=#9399B2,bold,italic] {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                tab_fullscreen_indicator "□ "
                tab_sync_indicator       " "
                tab_floating_indicator   "󰉈 "

                command_git_branch_command  "git rev-parse --abbrev-ref HEAD"
                command_git_branch_format   "#[fg=#a6e3a1] {stdout} "
                command_git_branch_interval "10"

                datetime          "#[fg=#9399B2] {format} "
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
