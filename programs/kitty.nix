{ home-manager, username, pkgs, lib, ... }:

{
  home-manager.users.${username} = {

    home.packages = with pkgs; [
      viu # Terminal image viewer with native support for Kitty
    ];

    programs.kitty = {
      enable = true;

      settings = {
        enable_audio_bell = "no";
        cursor_stop_blinking_after = "5.0";
        font_family = lib.mkDefault "JetBrainsMono Nerd Font";
        bold_font = lib.mkDefault "JetBrainsMono Nerd Font Bold";
        italic_font = lib.mkDefault "JetBrainsMono Nerd Font Italic";
        font_size = lib.mkDefault 14;
        window_padding_width = 8;
        hide_window_decorations = "yes";
        mouse_hide_wait = "3";
        text_composition_strategy = "1.0 80";
        background = "#000000";
      };

      keybindings = {
        "middle" = "paste_from_selection";
      };
    };
  };
}
