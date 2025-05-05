{pkgs, ...}: let
  nmcliExe = "${pkgs.networkmanager}/bin/nmcli";
in
  pkgs.writeShellScriptBin "wifi-status" ''
    interface=$(${nmcliExe} -t -f DEVICE,TYPE,STATE d | awk -F: '$2 == "wifi" && $3 == "connected" {print $1}')

    if [ -z "$interface" ]; then
      echo '{"text": "󰖪", "tooltip": "Wi-Fi: Disconnected"}'
      exit 0
    fi

    ssid=$(${nmcliExe} -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
    signal=$(${nmcliExe} -t -f IN-USE,SIGNAL dev wifi | grep '*' | cut -d':' -f2)

    if [ "$signal" -ge 80 ]; then
      icon="󰤨"
    elif [ "$signal" -ge 60 ]; then
      icon="󰤥"
    elif [ "$signal" -ge 40 ]; then
      icon="󰤢"
    elif [ "$signal" -ge 20 ]; then
      icon="󰤟"
    else
      icon="󰤯"
    fi

    echo "{\"text\": \"$icon\", \"tooltip\": \"Wi-Fi: $ssid ($signal%)\"}"
  ''
