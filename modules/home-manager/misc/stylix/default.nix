{
  pkgs,
  inputs,
  self,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.misc.stylix;
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.niri.homeModules.stylix
  ];

  options.internal.misc.stylix = {
    enable = mkEnableOption "stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
      image = self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg";
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
