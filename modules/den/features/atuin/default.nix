{
  den.aspects.atuin = {user}: {
    homeManager = {
      programs.atuin = {
        enable = true;
        daemon.enable = true;

        settings = {
          auto_sync = true;
          update_check = false;
          sync_address = "https://api.atuin.sh";
          sync_frequency = "1m";
          search_mode = "daemon-fuzzy";
          search_mode_shell_up_key_binding = "daemon-fuzzy";
          filter_mode = "workspace";
          filter_mode_shell_up_key_binding = "global";
          workspaces = true;
          style = "compact";
          inline_height = 26;
          show_preview = false;
          show_help = false;
          show_tabs = false;
          exit_mode = "return-original";
          history_format = "{time} {user}@{host}\\n{directory}\\n> {command} [{duration}]\\n";
          secrets_filter = true;
          show_numeric_shortcuts = false;
          command_chaining = true;
          enter_accept = true;
          keymap_mode = "auto";

          stats.common_prefix = ["sudo" ","];
          sync.records = true;
          ui.columns = ["time" "command"];
          daemon.autostart = true;
        };
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/share/atuin"
        ".atuin"
      ];
    };
  };
}
