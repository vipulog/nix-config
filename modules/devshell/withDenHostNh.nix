{
  lib,
  den,
  ...
}: {
  flake.lib.devshell = {
    withDenHostNh = pkgs: cmd: let
      denNhPackages = den.lib.nh.denPackages {fromFlake = true;} pkgs;
      availableHosts = builtins.attrNames denNhPackages;
      hostsStr = lib.concatStringsSep " " availableHosts;
      hostsPrettyStr = lib.concatStringsSep "\n" (map (h: "  - ${h}") availableHosts);
    in
      # sh
      ''
        HOST="''${HOST_NAME:?HOST_NAME is not set}"

        if [[ $# -gt 0 && "$1" != -* ]]; then
          HOST="$1"
          shift
        fi

        case " ${hostsStr} " in
          *" $HOST "*) ;;
          *)
            echo "error: invalid host '$HOST'" >&2
            echo >&2
            echo "available hosts:" >&2
            cat >&2 <<EOF
        ${hostsPrettyStr}
        EOF
            exit 1
            ;;
        esac

        "$HOST" ${cmd} --hostname "$HOST" "$@"
      '';
  };
}
