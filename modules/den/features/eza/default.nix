{
  den.aspects.eza = {
    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.eza];
    };

    homeManager = {
      programs.eza = {
        enable = true;
        icons = "auto";
        colors = "auto";
        git = true;
      };
    };
  };
}
