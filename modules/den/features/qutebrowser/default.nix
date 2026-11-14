{
  den.aspects.qutebrowser = {
    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.qutebrowser];
    };

    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };

    persist-user = {
      directories = {
        ".local/share/qutebrowser".enable = true;
        ".cache/qutebrowser".enable = true;
      };
    };
  };
}
