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

    persist-host = {
      directories = [
        "/var/lib/waydroid"
        "/etc/waydroid-extra"
      ];
    };

    persist-user = {
      directories = [
        ".local/share/waydroid"
      ];
    };
  };
}
