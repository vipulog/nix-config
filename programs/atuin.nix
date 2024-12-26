{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    atuin = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
