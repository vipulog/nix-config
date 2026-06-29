{
  den.aspects.zsh = {
    nixos = {
      environment.pathsToLink = ["/share/zsh"];
    };

    homeManager = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        fastSyntaxHighlighting.enable = true;
      };
    };
  };
}
