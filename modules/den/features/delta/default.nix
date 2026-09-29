{
  den.aspects.delta = {
    homeManager = {config, ...}: {
      programs.delta = {
        enable = true;
        enableGitIntegration = config.programs.git.enable;
        enableJujutsuIntegration = config.programs.jujutsu.enable;

        options = {
          diff-so-fancy = true;
          line-numbers = true;
          true-color = "always";
        };
      };
    };
  };
}
