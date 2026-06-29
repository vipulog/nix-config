{
  den.aspects.ssh = {
    homeManager = {
      programs.ssh = {
        enable = true;

        matchBlocks = {
          "*" = {
            addKeysToAgent = "yes";
            forwardAgent = true;
          };
        };
      };
    };
  };
}
