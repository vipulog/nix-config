{den, ...}: {
  den.aspects.distrobox = {
    includes = [den.aspects.podman];

    homeManager = {
      programs.distrobox = {
        enable = true;
        enableSystemdUnit = true;

        settings = {
          container_manager = "podman";
          container_always_pull = "1";
          container_name_default = "archlinux";
          container_image_default = "quay.io/toolbx/arch-toolbox:latest";

          container_additional_volumes = builtins.concatStringsSep " " [
            "/nix/store:/nix/store:ro"
            "/etc/profiles/per-user:/etc/profiles/per-user:ro"
            "/etc/static/profiles/per-user:/etc/static/profiles/per-user:ro"
          ];
        };

        containers = {
          archlinux = {
            entry = true;
            image = "quay.io/toolbx/arch-toolbox:latest";
          };
        };
      };
    };
  };
}
