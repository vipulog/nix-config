{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.niri.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = lib.custom.relativeToRoot "assets/wallpapers/nix-tux.png";
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
      applications = 0.96;
      desktop = 0.96;
      popups = 0.96;
      terminal = 0.96;
    };
  };
}
