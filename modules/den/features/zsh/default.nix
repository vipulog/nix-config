{
  den.aspects.zsh = let
    sharedModule = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
      };
    };
  in {
    os = {
      imports = [sharedModule];
    };

    nixos = {
      programs.zsh = {
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
      };
    };

    darwin = {
      programs.zsh = {
        enableAutosuggestions = true;
        enableFastSyntaxHighlighting = true;
      };
    };

    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      imports = [sharedModule];

      programs.zsh = {
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
