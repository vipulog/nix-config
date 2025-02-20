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

  padding = "2px 4px";
  margin = "2px 4px";
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
          "temperature"
          "memory"
          "disk"
        ];

        modules-center = [
          "niri/window"
        ];

        modules-right = [
          "tray"
          "privacy"
          "network"
          "pulseaudio"
          "battery"
          "clock"
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

        temperature = {
          format = " {temperatureC}°C";
        };

        memory = {
          format = "  {percentage}%";
        };

        disk = {
          format = "  {percentage_used}%";
        };

        tray = {
          icon-size = 12;
          spacing = 8;
        };

        privacy = {
          icon-spacing = 8;
          icon-size = 12;
          transition-duration = 250;
          modules = [
            {type = "audio-in";}
            {type = "audio-out";}
            {type = "screenshare";}
          ];
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
            min-height: 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.75);
        }

        window#waybar.empty {
            background-color: transparent;
        }

        #clock,
        #network,
        #battery,
        #pulseaudio,
        #tray,
        #privacy,
        #temperature,
        #memory,
        #disk,
        #custom-app-launcher,
        #custom-power {
            padding: ${padding};
            margin: ${margin};
        }
      '';
  };
}
