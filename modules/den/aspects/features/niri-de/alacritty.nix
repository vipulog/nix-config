{den, ...}: {
  den.aspects.niri-de = {
    includes = [den.aspects.alacritty];

    homeManager = {
      programs.alacritty = {
        settings = {
          general = {
            "import" = ["~/.config/alacritty/dank-theme.toml"];
          };

          window = {
            decorations = "None";
            opacity = 0.9;
          };
        };
      };
    };
  };
}
