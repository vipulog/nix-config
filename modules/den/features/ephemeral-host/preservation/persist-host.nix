{den, ...}: {
  den.aspects.ephemeral-host.preservation.persist-host = {
    includes = [den.aspects.ephemeral-host.preservation.persist-host.defaults];

    nixos = {
      lib,
      persist-host,
      ...
    }: {
      preservation.preserve = {
        files = lib.unique (lib.concatLists (
          map (p: p.files or []) persist-host
        ));

        directories = lib.unique (lib.concatLists (
          map (p: p.directories or []) persist-host
        ));
      };
    };

    defaults = {
      nixos = {config, ...}: let
        inherit (config.preservation) defaultPreserveAt;
      in {
        systemd.services.systemd-machine-id-commit = {
          unitConfig.ConditionPathIsMountPoint = [
            ""
            "${defaultPreserveAt}/etc/machine-id"
          ];

          serviceConfig.ExecStart = [
            ""
            "systemd-machine-id-setup --commit --root ${defaultPreserveAt}"
          ];
        };
      };

      persist-host = {
        directories = [
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ];

        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
            how = "symlink";
          }
        ];
      };
    };
  };
}
