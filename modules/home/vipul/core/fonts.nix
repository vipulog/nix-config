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
    noto-fonts-emoji
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    inter
    merriweather
  ];
}
