{pkgs, ...}: let
  pactlExe = "${pkgs.pulseaudio}/bin/pactl";
in
  pkgs.writeShellScriptBin "audio-in-status" ''
    volume=$(${pactlExe} get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | head -n 1 | sed 's/%//')
    mute=$(${pactlExe} get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
    active=$(${pactlExe} list source-outputs | grep -q 'Source Output' && echo "yes" || echo "no")

    if [ "$active" = "yes" ]; then
            if [ "$mute" = "yes" ]; then
                icon=""
            else
                icon=" "
            fi
    else
            icon=""
    fi

    echo "{\"text\": \"$icon\", \"tooltip\": \"Mic: $volume% (in use)\"}"
  ''
