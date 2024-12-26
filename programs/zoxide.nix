{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
