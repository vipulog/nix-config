{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };
  };
}
