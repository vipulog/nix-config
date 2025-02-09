{
  pkgs,
  lib,
  ...
}: let
  terminal = lib.getExe pkgs.ghostty;
  nmtui = "${terminal} -e ${lib.getExe' pkgs.networkmanager "nmtui"}";
  pulsemixer = "${terminal} -e ${lib.getExe pkgs.pulsemixer}";
  tofi-drun = lib.getExe' pkgs.tofi "tofi-drun";
  power-tofi = lib.getExe (pkgs.callPackage ./scripts/power-tofi.nix {});

  volume-up = "${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ +5%";
  volume-down = "${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ -5%";

  fontFamily = "JetBrainsMono Nerd Font";
  fontSize = "14px";
  padding = "2px 4px";
  margin = "2px 4px";
  background = "#000000";
  textColor = "#ffffff";
in {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "custom/app-launcher"
          "custom/divider"
        ];

        modules-center = [
          "niri/window"
        ];

        modules-right = [
          "tray"
          "custom/divider"
          "network"
          "custom/divider"
          "pulseaudio"
          "custom/divider"
          "custom/battery-placeholder"
          "battery"
          "custom/divider"
          "clock"
          "custom/divider"
          "custom/power"
        ];

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "Current Time: {:%A, %B %d, %Y - %H:%M}";
        };

        network = {
          format = "{icon}  {essid}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          tooltip-format = "SSID: {essid}\nSignal: {signalStrength}%\nInterface: {ifname}";
          on-click = nmtui;
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-icons = ["" "" "" "" ""];
          tooltip-format = "Battery: {capacity}%";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "";
          format-icons = {default = ["" "" ""];};
          tooltip-format = "Volume: {volume}%";
          on-click = pulsemixer;
          on-scroll-up = volume-up;
          on-scroll-down = volume-down;
        };

        tray = {
          icon-size = 16;
          spacing = 2;
        };

        "custom/divider" = {
          format = "│";
          tooltip = false;
        };

        "custom/app-launcher" = {
          format = "   ";
          on-click = tofi-drun;
          tooltip-format = "App Launcher";
        };

        "custom/power" = {
          format = "⏻ ";
          on-click = power-tofi;
          tooltip-format = "Power Menu";
        };

        "custom/battery-placeholder" = {
          exec = "if [ ! -d /sys/class/power_supply/BAT0 ]; then echo '󰁽 NA'; fi";
          interval = 10;
          tooltip = false;
        };
      };
    };

    style =
      /*
      css
      */
      ''
        * {
            border: none;
            border-radius: 0;
            font-family: ${fontFamily};
            font-size: ${fontSize};
            min-height: 0;
        }

        window#waybar {
            background: ${background};
            color: ${textColor};
        }

        #clock,
        #network,
        #battery,
        #pulseaudio,
        #tray,
        #custom-app-launcher,
        #custom-power,
        #custom-battery-placeholder,
        #custom-tray-placeholder {
            padding: ${padding};
            margin: ${margin};
        }

        #custom-app-launcher {
          font-size: 16px;
          padding: 0;
          margin: 0;
        }

        #custom-power {
            font-weight: bold;
            color: ${textColor};
        }

        #custom-divider {
            font-size: 10px;
            opacity: 0.5;
        }
      '';
  };
}
