{den, ...}: {
  den.aspects.niri-de.dms.alacritty = {
    includes = [den.aspects.alacritty];

    homeManager = {lib, ...}: {
      home.activation.dmsAlacrittyConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
        touch "$HOME/.config/alacritty/dank-theme.toml"
      '';

      programs.alacritty = {
        settings = {
          general.import = ["~/.config/alacritty/dank-theme.toml"];

          window = {
            decorations = "None";
            opacity = 0.9;
          };
        };
      };
    };
  };
}
