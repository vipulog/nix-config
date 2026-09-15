{den, ...}: {
  den.aspects.tux.jujutsu = {
    includes = [den.aspects.jujutsu];

    homeManager = {
      programs.jujutsu = {
        settings = {
          user.name = "vipulog";
          user.email = "90324465+vipulog@users.noreply.github.com";
        };
      };
    };
  };
}
