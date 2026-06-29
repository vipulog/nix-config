{den, ...}: {
  den.aspects.delta = {user ? null, ...}: {
    homeManager = {
      programs.delta = {
        enable = true;
        enableGitIntegration = user.hasAspect den.aspects.git;
        enableJujutsuIntegration = user.hasAspect den.aspects.jujutsu;

        options = {
          diff-so-fancy = true;
          line-numbers = true;
          true-color = "always";
        };
      };
    };
  };
}
