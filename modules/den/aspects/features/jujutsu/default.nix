{
  den.aspects.jujutsu = {
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
