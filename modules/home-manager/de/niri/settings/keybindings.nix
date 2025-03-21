{
  config,
  pkgs,
  lib,
  ...
}:
with config.lib.niri.actions;
with lib; let
  cfg = config.internal.de.niri;
  sh = spawn "sh" "-c";
in {
  config = mkIf cfg.enable {
    programs.niri.settings.binds = mergeAttrsList [
      # Workspace Navigation
      {
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;
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
        "Mod+C".action = center-column;

        "Mod+L".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+Ctrl+L".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
      }

      # Window Management
      {
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;

        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Q".action = close-window;

        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+Ctrl+J".action = move-window-down;
        "Mod+Ctrl+K".action = move-window-up;

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
      }

      # Screenshots
      {
        "Print".action = screenshot;
        "Mod+Print".action = screenshot-window;
        "Mod+Shift+Print".action = screenshot-screen;
      }

      # Application Launchers
      {
        "Mod+T".action = spawn "${getExe pkgs.ghostty}";
        "Mod+Ctrl+V".action = sh "${getExe pkgs.ghostty} -e '${getExe pkgs.clipse}'";
      }

      # System Actions
      {
        "Mod+Shift+E".action = quit;
        "Ctrl+Alt+Delete".action = quit;
        "Mod+Shift+Slash".action = show-hotkey-overlay;
      }
    ];
  };
}
