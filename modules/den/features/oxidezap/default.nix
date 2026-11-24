{
  den.aspects.oxidezap = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.oxidezap];
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.oxidezap];
    };

    persist-user = {
      directories = {
        ".config/oxidezap".enable = true;
        ".local/share/oxidezap".enable = true;
      };
    };
  };
}
