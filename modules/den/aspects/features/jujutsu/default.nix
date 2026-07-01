{
  den.aspects.jujutsu = {
    homeManager = {
      lib,
      user,
      ...
    }: {
      programs.jujutsu = {
        enable = true;

        settings = lib.mkMerge [
          {ui.default-command = ["log" "-n" "5"];}

          (lib.mkIf (user.name == "tux") {
            user = {
              name = "vipulog";
              email = "90324465+vipulog@users.noreply.github.com";
            };
          })
        ];
      };
    };
  };
}
