{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
