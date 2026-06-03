{
  lib,
  den,
  inputs,
  self,
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
    withHostNh = self.lib.den.withHostNh pkgs;
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
              command = withHostNh "build";
            }
            {
              name = "host-test";
              help = "builds and activates the configuration";
              command = withHostNh "test --ask";
            }
            {
              name = "host-boot";
              help = "builds the configuration and sets it as the boot default";
              command = withHostNh "boot --ask";
            }
            {
              name = "host-switch";
              help = "builds, activates, and sets the configuration as the boot default";
              command = withHostNh "switch --ask";
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
