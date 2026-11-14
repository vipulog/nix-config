{
  den.aspects.jujutsu = {
    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.jujutsu];
    };

    homeManager = {
      programs.jujutsu = {
        enable = true;

        settings = {
          ui.default-command = ["log" "-n" "5"];
        };
      };
    };
  };
}
