{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    fzf = {
      enable = true;
    };
  };
}
