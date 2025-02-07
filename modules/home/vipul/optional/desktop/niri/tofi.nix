{
  pkgs,
  lib,
  ...
}: {
  programs.tofi = {
    enable = true;

    settings = {
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      hint-font = false;
      ascii-input = true;
      late-keyboard-init = true;
      terminal = "${lib.getExe pkgs.ghostty} -e";
      anchor = "bottom";
      width = "100%";
      height = 46;
      horizontal = true;
      font-size = 13;
      prompt-text = " run: ";
      outline-width = 0;
      border-width = 4;
      border-color = "#7fc8ff";
      selection-color = "#ffffff";
      default-result-color = "#7c7c7c";
      background-color = "#000000";
      min-input-width = 8;
      result-spacing = 42;
      padding-top = 8;
      padding-bottom = 8;
      padding-left = 8;
      padding-right = 8;
    };
  };
}
