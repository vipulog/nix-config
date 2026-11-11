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
      directories = [
        "/var/lib/sddm"
      ];
    };

    persist-user = {
      directories = [
        ".local/share/kwalletd"
        ".local/share/kscreen"
        ".local/share/plasma"
        ".local/share/dolphin"
        ".local/share/konsole"
        ".config/kde.org"
        ".config/gtk-3.0"
        ".config/gtk-4.0"
      ];

      files = [
        ".config/kwinoutputconfig.json"
        ".config/kcminputrc"
        ".config/powerdevilrc"
        ".config/kscreenlockerrc"

        ".config/kdeglobals"
        ".config/kwinrc"
        ".config/plasma-org.kde.plasma.desktop-appletsrc"
        ".config/plasmashellrc"
        ".config/plasmarc"
        ".config/kglobalshortcutsrc"
        ".config/dolphinrc"
        ".config/konsolerc"
      ];
    };
  };
}
