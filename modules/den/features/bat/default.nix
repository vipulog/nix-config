{
  den.aspects.bat = {user}: {
    homeManager = {
      programs.bat = {
        enable = true;
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".cache/bat"
      ];
    };
  };
}
