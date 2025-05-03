{
  pkgs,
  inputs,
  lib,
  self,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
  cfg = senkaiCfg.theme;
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.niri.homeModules.stylix
  ];

  options.internal.de.senkai.theme = {
    wallpaper = mkOption {
      type = types.path;
      default = self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg";
      description = "Path to the wallpaper image";
    };

    scheme = mkOption {
      type = types.path;
      default = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
      description = "Path to the base16 color scheme";
    };
  };

  config = mkIf senkaiCfg.enable {
    stylix = {
      enable = true;
      base16Scheme = cfg.scheme;
      image = cfg.wallpaper;
      polarity = "dark";

      cursor = {
        package = pkgs.simp1e-cursors;
        name = "Simp1e";
        size = 32;
      };

      fonts = {
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji;
        };

        monospace = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };

        sansSerif = {
          name = "Inter";
          package = pkgs.inter;
        };

        serif = {
          name = "Merriweather";
          package = pkgs.merriweather;
        };

        sizes = {
          applications = 12;
          desktop = 12;
          popups = 12;
          terminal = 14;
        };
      };

      iconTheme = {
        enable = true;
        package = pkgs.colloid-icon-theme.override {
          schemeVariants = ["catppuccin"];
          colorVariants = ["purple"];
        };
        light = "Colloid-Purple-Catppuccin-Light";
        dark = "Colloid-Purple-Catppuccin-Dark";
      };

      opacity = {
        applications = 1.0;
        desktop = 1.0;
        popups = 1.0;
        terminal = 1.0;
      };
    };
  };
}
