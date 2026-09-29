{den, ...}: {
  den.aspects.waydroid = {user}: {
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

    persist = {
      preserve = {
        directories = [
          "/var/lib/waydroid"
          "/etc/waydroid-extra"
        ];

        users.${user.name}.directories = [
          ".local/share/waydroid"
        ];
      };
    };
  };
}
