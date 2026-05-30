{
  flake.wrappers.alacritty = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.alacritty];

    env = {
      FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = [
          pkgs.nerd-fonts.jetbrains-mono
        ];
      };
    };

    settings = {
      window.padding = {
        x = 12;
        y = 12;
      };

      cursor = {
        blink_interval = 500;
        unfocused_hollow = true;

        style = {
          shape = "Block";
          blinking = "On";
        };
      };

      scrolling.history = 3000;
      mouse.hide_when_typing = true;
      selection.save_to_clipboard = false;
      bell.duration = 0;

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };

      keyboard.bindings = [
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
        {
          key = "Equals";
          mods = "Control|Shift";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Enter";
          mods = "Shift";
          chars = "\n";
        }
      ];
    };
  };
}
