{den, ...}: {
  den.aspects.gaming-de = {
    includes = [den.aspects.steam];

    nixos = {pkgs, ...}: {
      services = {
        desktopManager = {
          plasma6.enable = true;
        };

        displayManager = {
          defaultSession = "plasma";

          sddm = {
            enable = true;
            wayland.enable = true;
          };
        };

        orca.enable = false;
      };

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        discover
        khelpcenter
        krdp
        dolphin-plugins
        qrca
      ];

      programs.kde-pim.enable = false;

      environment.etc."xdg/autostart/steam-bigpicture.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=Steam Big Picture
        Exec=steam -bigpicture
      '';
    };

    persist-host = {
      directories = {
        "/var/lib/sddm".enable = true;
      };
    };

    persist-user = {
      directories = {
        ".local/share/kwalletd".enable = true;
        ".local/share/kscreen".enable = true;
        ".local/share/plasma".enable = true;
        ".local/share/dolphin".enable = true;
        ".local/share/konsole".enable = true;
        ".config/kde.org".enable = true;
        ".config/gtk-3.0".enable = true;
        ".config/gtk-4.0".enable = true;
      };

      files = {
        ".config/kwinoutputconfig.json".enable = true;
        ".config/kcminputrc".enable = true;
        ".config/powerdevilrc".enable = true;
        ".config/kscreenlockerrc".enable = true;

        ".config/kdeglobals".enable = true;
        ".config/kwinrc".enable = true;
        ".config/plasma-org.kde.plasma.desktop-appletsrc".enable = true;
        ".config/plasmashellrc".enable = true;
        ".config/plasmarc".enable = true;
        ".config/kglobalshortcutsrc".enable = true;
        ".config/dolphinrc".enable = true;
        ".config/konsolerc".enable = true;
      };
    };
  };
}
