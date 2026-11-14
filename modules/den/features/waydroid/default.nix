{den, ...}: {
  den.aspects.waydroid = {
    includes = [den.aspects.polkit];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.waydroid-helper
        pkgs.wl-clipboard
      ];

      virtualisation.waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
      };
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.waydroid-nftables];
    };

    persist-host = {
      directories = {
        "/var/lib/waydroid".enable = true;
        "/etc/waydroid-extra".enable = true;
      };
    };

    persist-user = {
      directories = {
        ".local/share/waydroid".enable = true;
      };
    };
  };
}
