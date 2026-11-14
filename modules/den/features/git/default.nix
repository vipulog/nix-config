{
  den.aspects.git = let
    gitSettings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  in {
    nixos = {
      programs.git = {
        enable = true;
        config = gitSettings;
      };
    };

    darwin = {pkgs, ...}: {
      environment.systemPackages = [pkgs.git];
    };

    homeManager = {
      programs.git = {
        enable = true;
        settings = gitSettings;
      };
    };
  };
}
