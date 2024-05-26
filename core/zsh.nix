{ username, home-manager, ... }:

{
  programs.zsh.enable = true;

  home-manager.users.${username} = { config, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        # cd = "z";
      };

      history = {
        size = 1000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };
  };
}
