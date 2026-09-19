{
  den.aspects.bat = {
    homeManager = {
      programs.bat = {
        enable = true;
      };
    };

    persist-user = {
      directories = [
        ".cache/bat"
      ];
    };
  };
}
