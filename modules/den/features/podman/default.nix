{
  den.aspects.podman = let
    mkCommonPkgs = pkgs: [
      pkgs.dive
      pkgs.podman-tui
      pkgs.docker-compose
    ];
  in {
    nixos = {pkgs, ...}: {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      environment.systemPackages = mkCommonPkgs pkgs;
    };

    homeManager = {pkgs, ...}: {
      services.podman.enable = true;
      home.packages = mkCommonPkgs pkgs;
    };

    persist-user = {
      directories = {
        ".local/share/containers".enable = true;
      };
    };
  };
}
