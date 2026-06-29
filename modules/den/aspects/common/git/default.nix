{lib, ...}: {
  den.aspects.git = {user ? null, ...}: {
    homeManager = {
      programs.git = {
        enable = true;

        settings = lib.mkMerge [
          {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            pull.rebase = true;
            url."git@github.com:".insteadOf = "https://github.com/";
          }

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
