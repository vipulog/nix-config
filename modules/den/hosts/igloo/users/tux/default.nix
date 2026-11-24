{den, ...}: {
  den.aspects."tux@igloo" = {
    includes = [
      den.batteries.primary-user
      den.aspects.sops-nix
      den.aspects.tailscale
      den.aspects.niri-de
      den.aspects.podman
      den.aspects.distrobox
      den.aspects.waydroid
      den.aspects.zed-editor
      den.aspects.chromium
      den.aspects.firefox
      den.aspects.redirector
      den.aspects.kdeconnect
      den.aspects.lutris
      den.aspects.sable
      den.aspects.vesktop
      den.aspects.oxidezap
      den.aspects."tux@igloo".syncthing
    ];

    user = {config, ...}: {
      hashedPasswordFile = config.sops.secrets.tux-password.path;
    };

    homeManager = {
      home.stateVersion = "26.05";

      wayland.windowManager.niri.extraConfig = ''
        output "eDP-1" {
            scale 1.25
            transform "normal"
            mode "1920x1080@60"
        }

        input {
            touchpad {
                tap
                dwt
                natural-scroll
            }
        }
      '';
    };

    persist-user = {
      directories = {
        "DCIM".enable = true;
        "Recordings".enable = true;
      };
    };
  };
}
