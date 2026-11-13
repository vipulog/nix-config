{
  den.aspects.zsh = {
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

    persist-user = {
      files = {
        ".zsh_history" = {
          enable = true;
          how = "symlink";
          mode = "0600";
        };
      };

      directories = {
        ".cache/fastfetch".enable = true;
      };
    };
  };
}
