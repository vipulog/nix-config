{den, ...}: {
  den.aspects.tux.git = {
    includes = [den.aspects.git];

    homeManager = {
      programs.git = {
        settings = {
          user.name = "vipulog";
          user.email = "90324465+vipulog@users.noreply.github.com";
        };
      };
    };
  };
}
