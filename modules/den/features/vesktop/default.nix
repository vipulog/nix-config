{
  den.aspects.vesktop = {
    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.vesktop];
    };

    homeManager = {
      programs.vesktop.enable = true;
    };

    persist-user = {
      directories = {
        ".config/vesktop".enable = true;
      };
    };
  };
}
