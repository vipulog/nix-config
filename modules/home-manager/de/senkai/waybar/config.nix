{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;

  wifiStatusScript = "${getExe (pkgs.callPackage ./scripts/wifi-status.nix {})}";
  wifiSettingsCmd = "${getExe' pkgs.networkmanagerapplet "nm-connection-editor"}";

  osdClientExe = getExe' pkgs.swayosd "swayosd-client";
  audioSettingsCmd = "${getExe pkgs.pavucontrol}";

  audioInStatusScript = "${getExe (pkgs.callPackage ./scripts/audio-in-status.nix {})}";
  audioInToggleCmd = "${osdClientExe} --input-volume mute-toggle";
  audioInRaiseCmd = "${osdClientExe} --input-volume raise";
  audioInLowerCmd = "${osdClientExe} --input-volume lower";

  audioOutStatusScript = "${getExe (pkgs.callPackage ./scripts/audio-out-status.nix {})}";
  audioOutToggleCmd = "${osdClientExe} --output-volume mute-toggle";
  audioOutRaiseCmd = "${osdClientExe} --output-volume raise";
  audioOutLowerCmd = "${osdClientExe} --output-volume lower";
in {
  config = mkIf senkaiCfg.enable {
    xdg.configFile."waybar/config".text = ''
      {
          "layer": "top",
          "position": "right",
          "width": 60,
          "modules-left": ["niri/workspaces"],
          "modules-center": ["clock"],
          "modules-right": ["group/audio", "group/network"],

          "clock": {
            "format": "{:%I\n%M\n%p}",
            "tooltip-format": "{:%A, %d %B %Y}"
          },

          "group/network": {
            "orientation": "vertical",
            "modules": ["custom/wifi"]
          },

          "custom/wifi": {
            "exec": "${wifiStatusScript}",
            "interval": 1,
            "return-type": "json",
            "hide-empty-text": true,
            "justify": "center",
            "on-click-right": "${wifiSettingsCmd}"
          },

          "group/audio": {
            "orientation": "vertical",
            "modules": ["custom/audio-in", "custom/audio-out"]
          },

          "custom/audio-in": {
            "exec": "${audioInStatusScript}",
            "interval": 1,
            "return-type": "json",
            "hide-empty-text": true,
            "justify": "center",
            "on-click": "${audioInToggleCmd}",
            "on-click-right": "${audioSettingsCmd}",
            "on-scroll-up": "${audioInRaiseCmd}",
            "on-scroll-down": "${audioInLowerCmd}"
          },

          "custom/audio-out": {
            "exec": "${audioOutStatusScript}",
            "interval": 1,
            "return-type": "json",
            "hide-empty-text": true,
            "justify": "center",
            "align": 0.5,
            "on-click": "${audioOutToggleCmd}",
            "on-click-right": "${audioSettingsCmd}",
            "on-scroll-up": "${audioOutRaiseCmd}",
            "on-scroll-down": "${audioOutLowerCmd}"
          }
        }
    '';
  };
}
