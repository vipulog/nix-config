{
  den.aspects.zoxide = {user}: {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/share/zoxide"
      ];
    };
  };
}
