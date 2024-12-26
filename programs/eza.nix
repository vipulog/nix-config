{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
  };
}
