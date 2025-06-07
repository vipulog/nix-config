{
  config,
  pkgs,
  lib,
  ...
}:
with config.lib.niri.actions;
with lib; let
  senkaiCfg = config.internal.de.senkai;
  sh = spawn "sh" "-c";
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.binds = mergeAttrsList [
      # Workspace Navigation
      {
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;

        "Mod+Ctrl+1".action = move-column-to-index 1;
        "Mod+Ctrl+2".action = move-column-to-index 2;
        "Mod+Ctrl+3".action = move-column-to-index 3;
        "Mod+Ctrl+4".action = move-column-to-index 4;
        "Mod+Ctrl+5".action = move-column-to-index 5;
      }

      # Monitor Navigation
      {
        "Mod+Shift+L".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;

        "Mod+Ctrl+Shift+L".action = move-column-to-monitor-right;
        "Mod+Ctrl+Shift+H".action = move-column-to-monitor-left;
        "Mod+Ctrl+Shift+J".action = move-column-to-monitor-down;
        "Mod+Ctrl+Shift+K".action = move-column-to-monitor-up;
      }

      # Column Management
      {
        "Mod+R".action = switch-preset-column-width;

        "Mod+F".action = maximize-column;
        "Mod+Ctrl+F".action = expand-column-to-available-width;
        "Mod+C".action = center-column;

        "Mod+L".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+Ctrl+L".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+W".action = toggle-column-tabbed-display;
      }

      # Window Management
      {
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;

        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Q".action = close-window;

        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
      }

      # System Actions
      {
        "Mod+Shift+E".action = quit;
        "Ctrl+Alt+Delete".action = quit;
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+Space".action = sh "flock -n /tmp/wofi.lock wofi --show drun";
      }

      # Volume Control
      {
        "XF86AudioMicMute".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--input-volume" "mute-toggle";
        "XF86AudioMute".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--output-volume" "mute-toggle";
        "XF86AudioRaiseVolume".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--output-volume" "raise";
        "XF86AudioLowerVolume".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--output-volume" "lower";

        "Mod+F9".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--input-volume" "mute-toggle";
        "Mod+F10".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--output-volume" "mute-toggle";
        "Mod+F11".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--output-volume" "raise";
        "Mod+F12".action = spawn "${getExe' pkgs.swayosd "swayosd-client"}" "--output-volume" "lower";
      }

      # Screenshots
      {
        "Print".action = screenshot;
        "Mod+Print".action = screenshot-window;
        # "Mod+Shift+Print".action = screenshot-screen;
        # https://github.com/sodiboo/niri-flake/issues/922
        "Mod+Shift+Print".action.screenshot-screen = [];
      }

      # Applications
      {
        "Mod+T".action = spawn "${getExe pkgs.ghostty}";
        "Mod+Ctrl+V".action = sh "${getExe pkgs.ghostty} --title=clipse --command=${getExe pkgs.clipse}";
      }
    ];
  };
}
