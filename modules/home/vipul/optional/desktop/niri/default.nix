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
    ./wpaperd.nix
  ];

  programs.niri.settings = {
    outputs."HDMI-A-1" = {
      scale = 1.0;
      background-color = "#000000";

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

      border = {
        enable = true;
        active = {color = "#7fc8ff";};
        inactive = {color = "#7c7c7c";};
        width = 4;
      };

      focus-ring = {
        enable = false;
      };
    };

    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in
      lib.attrsets.mergeAttrsList [
        {
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;

          "Mod+Shift+1".action = move-column-to-workspace 1;
          "Mod+Shift+2".action = move-column-to-workspace 2;
          "Mod+Shift+3".action = move-column-to-workspace 3;
          "Mod+Shift+4".action = move-column-to-workspace 4;
          "Mod+Shift+5".action = move-column-to-workspace 5;
          "Mod+Shift+6".action = move-column-to-workspace 6;
          "Mod+Shift+7".action = move-column-to-workspace 7;
          "Mod+Shift+8".action = move-column-to-workspace 8;
          "Mod+Shift+9".action = move-column-to-workspace 9;
        }
        {
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+R".action = switch-preset-column-width;
          "Mod+Ctrl+R".action = reset-window-height;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Backspace".action = close-window;
          "Mod+Q".action = close-window;
          "Mod+F".action = maximize-column;
          "Mod+C".action = center-column;

          "Mod+Shift+Right".action = move-column-right;
          "Mod+Shift+Left".action = move-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Left".action = focus-column-left;

          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+H".action = move-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+H".action = focus-column-left;

          "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
          "Mod+Down".action = focus-window-or-workspace-down;
          "Mod+Up".action = focus-window-or-workspace-up;

          "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;

          "Mod+Shift+Tab".action = focus-window-up-or-column-left;
          "Mod+Tab".action = focus-window-down-or-column-right;

          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
        }
        {
          "Mod+Print".action = screenshot-window;
          "Print".action = screenshot-screen;
          "Mod+Shift+S".action = screenshot;
        }
        {
          "Mod+V".action = sh "${getExe pkgs.kitty} -e '${getExe pkgs.clipse}'";
          "Mod+Space".action = sh "${getExe' pkgs.tofi "tofi-drun"} | xargs niri msg action spawn --";
          "Mod+Shift+Space".action = sh "${getExe' pkgs.tofi "tofi-run"} | xargs niri msg action spawn --";
          "Mod+Return".action = spawn "${getExe pkgs.kitty}";
          "Mod+Period".action = spawn "${getExe bemoji-tofi}";
        }
        {
          "Mod+Shift+Backspace".action = quit;
          "Mod+Shift+Q".action = quit;
          "Mod+F4".action = spawn "${getExe power-tofi}";
          "Mod+Shift+Slash".action = show-hotkey-overlay;
        }
      ];

    spawn-at-startup = [
      {command = ["sh" "-c" "${getExe pkgs.kitty} -e '${getExe pkgs.btop}'"];}
      {command = ["${getExe pkgs.wpaperd}" "--daemon"];}
      {command = ["${getExe pkgs.xwayland-satellite}"];}
      {command = ["${getExe pkgs.clipse}" "-listen"];}
    ];
  };

  home = {
    pointerCursor = {
      package = pkgs.simp1e-cursors;
      name = "Simp1e";
    };
  };
}
