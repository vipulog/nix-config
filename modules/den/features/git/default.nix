{
  den.aspects.git = {
    homeManager = {
      programs.git = {
        enable = true;

        settings = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          pull.rebase = true;
          url."git@github.com:".insteadOf = "https://github.com/";
        };
      };
    };
  };
}
