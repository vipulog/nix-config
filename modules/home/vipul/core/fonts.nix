{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = ["JetbrainsMono"];
      sansSerif = ["Inter"];
      serif = ["Merriweather"];

      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
    };
  };

  home.packages = with pkgs; [
    noto-fonts-emoji # For Noto Color Emoji and Noto Emoji
    jetbrains-mono # For JetbrainsMono
    inter # For Inter
    merriweather # For Merriweather
  ];
}
