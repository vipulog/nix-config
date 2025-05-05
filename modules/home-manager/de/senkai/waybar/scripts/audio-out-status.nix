{pkgs, ...}: let
  pactlExe = "${pkgs.pulseaudio}/bin/pactl";
in
  pkgs.writeShellScriptBin "audio-out-status" ''
    volume=$(${pactlExe} get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1 | sed 's/%//')
    mute=$(${pactlExe} get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    if [ "$mute" = "yes" ]; then
        icon=""
    else
        if [ "$volume" -ge 66 ]; then
            icon=""
        elif [ "$volume" -ge 33 ]; then
            icon=""
        else
            icon=""
        fi
    fi

    echo "{\"text\": \"$icon\", \"tooltip\": \"Volume: $volume%\"}"
  ''
