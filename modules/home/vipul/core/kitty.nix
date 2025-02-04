{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = "no";
      cursor_stop_blinking_after = "5.0";
      mouse_hide_wait = "3";
      background_opacity = "0.92";
      window_border_width = "20px";
    };

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetbrainsMono Nerd Font";
      size = 13;
    };

    shellIntegration.enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    viu # Terminal image viewer with native support for Kitty
  ];
}
