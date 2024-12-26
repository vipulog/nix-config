{ username, home-manager, ... }: {
  home-manager.users.${username}.programs = {
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings = {
        add_newline = false;
        nix_shell = {
          symbol = "❄️ ";
        };
      };
    };
  };
}
