{
  lib,
  den,
  inputs,
  ...
}: {
  imports = [inputs.devshell.flakeModule];

  flake-file.inputs = {
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  perSystem = {
    pkgs,
    config,
    ...
  }: let
    denShell = den.lib.nh.denShell {fromFlake = true;} pkgs;
    denNhPackages = den.lib.nh.denPackages {fromFlake = true;} pkgs;

    withHost = cmd: let
      availableHosts = builtins.attrNames denNhPackages;
      hostsStr = lib.concatStringsSep " " availableHosts;
      hostsPrettyStr = lib.concatStringsSep "\n" (map (h: "  - ${h}") availableHosts);
    in (
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
      ''
    );

    addCategory = category: map (cmd: cmd // {inherit category;});
  in {
    devshells.default = {
      packagesFrom = [
        config.pre-commit.devShell
        config.treefmt.build.devShell
        denShell
      ];

      env = [
        {
          name = "HOST_NAME";
          eval = "$(hostname -s)";
        }
        {
          name = "NIX_SYSTEM";
          eval = "$(nix-instantiate --raw --strict --eval -E builtins.currentSystem)";
        }
      ];

      commands = lib.flatten [
        [
          {
            name = "fmt";
            help = "formats the code";
            command = "nix fmt $@";
          }
        ]

        (
          lib.pipe [
            {
              name = "host-build";
              help = "builds the configuration";
              command = withHost "build";
            }
            {
              name = "host-test";
              help = "builds and activates the configuration";
              command = withHost "test --ask";
            }
            {
              name = "host-boot";
              help = "builds the configuration and sets it as the boot default";
              command = withHost "boot --ask";
            }
            {
              name = "host-switch";
              help = "builds, activates, and sets the configuration as the boot default";
              command = withHost "switch --ask";
            }
            {
              name = "host-build-vm";
              help = "builds the vm configuration";
              command = withHost "build-vm";
            }
            {
              name = "host-run-vm";
              help = "builds and runs the vm configuration";
              command = withHost "build-vm --run";
            }
          ] [(addCategory "[host commands]")]
        )
      ];

      devshell.startup = {
        header.text = ''
          echo
          echo "==== devshell startup ===="
          echo
        '';

        pre-commit-shell-hook = {
          deps = ["header"];

          text = ''
            echo "[RUN ] pre-commit-shell-hook"
            ${config.pre-commit.shellHook}
            echo "[DONE] pre-commit-shell-hook"
            echo
          '';
        };

        footer = {
          deps = ["pre-commit-shell-hook"];

          text = ''
            echo "==== ready ===="
            echo
          '';
        };
      };
    };
  };
}
