{
  den.aspects.zsh = {user}: {
    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        fastSyntaxHighlighting.enable = true;

        plugins = [
          {
            name = "welcome";
            src = pkgs.writeTextDir "welcome.plugin.zsh" ''
              [[ -o interactive ]] || return
              ${lib.getExe pkgs.fastfetch} -l "none"
            '';
          }
        ];
      };
    };

    persist = {
      preserve.users.${user.name} = {
        files = [
          {
            how = "symlink";
            file = ".zsh_history";
            mode = "0600";
          }
        ];

        directories = [".cache/fastfetch"];
      };
    };
  };
}
