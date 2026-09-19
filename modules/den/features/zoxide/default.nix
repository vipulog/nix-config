{
  den.aspects.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };
    };

    persist-user = {
      directories = [
        ".local/share/zoxide"
      ];
    };
  };
}
