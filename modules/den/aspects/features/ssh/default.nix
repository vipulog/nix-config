{
  den.aspects.ssh = {
    homeManager = {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings."*" = {
          addKeysToAgent = "yes";
          forwardAgent = true;
        };
      };
    };
  };
}
