{
  den.aspects.jujutsu = {
    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.jujutsu];
    };

    homeManager = {config, ...}: {
      programs.jujutsu = {
        enable = true;

        settings = {
          ui.default-command = ["log" "-n" "5"];

          user = {
            inherit (config.programs.git.settings.user) name email;
          };
        };
      };
    };
  };
}
