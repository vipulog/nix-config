{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe getExe';
  bemoji-tofi = pkgs.callPackage ./scripts/bemoji-tofi.nix {};
  power-tofi = pkgs.callPackage ./scripts/power-tofi.nix {};
in {
  imports = [
    ./tofi.nix
    ./stylix.nix
    ./wpaperd.nix
    ./mako.nix
    ./waybar.nix
  ];

  programs.niri.settings = {
    outputs."HDMI-A-1" = {
      scale = 1.0;

      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.000;
      };
    };

    environment = {
      DISPLAY = ":0";
    };

    cursor = {
      hide-after-inactive-ms = 5000;
      hide-when-typing = true;
    };

    prefer-no-csd = true;

    hotkey-overlay = {
      skip-at-startup = true;
    };

    layout = {
      gaps = 8;
    };

    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
      }
    ];

    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in
      lib.attrsets.mergeAttrsList [
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
          "Mod+D".action = sh "${getExe' pkgs.tofi "tofi-drun"} | xargs niri msg action spawn --";
          "Mod+W".action = sh "if pidof waybar > /dev/null; then kill $(pidof waybar); else waybar; fi";
          "Mod+E".action = spawn "${getExe bemoji-tofi}";
          "Mod+Shift+P".action = spawn "${getExe power-tofi}";
        }

        # System Actions
        {
          "Mod+Shift+E".action = quit;
          "Ctrl+Alt+Delete".action = quit;
          "Mod+Shift+Slash".action = show-hotkey-overlay;
        }
      ];

    spawn-at-startup = [
      {command = ["${getExe pkgs.wpaperd}" "--daemon"];}
      {command = ["${getExe pkgs.xwayland-satellite}"];}
      {command = ["${getExe pkgs.clipse}" "-listen"];}
    ];
  };
}
