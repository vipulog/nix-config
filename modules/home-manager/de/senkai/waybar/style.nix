{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.waybar.style = with config.lib.stylix.colors.withHashtag;
      mkAfter ''
        window#waybar {
            border-left: 1px solid ${base03};
        }

        .modules-left {
            margin-top: 16px;
        }

        .modules-right {
            margin-bottom: 16px;
        }

        #clock {
            font-weight: bold;
        }

        .modules-left #workspaces button,
        .modules-left #workspaces button.focused,
        .modules-left #workspaces button.active,
        .modules-center #workspaces button,
        .modules-center #workspaces button.focused,
        .modules-center #workspaces button.active,
        .modules-right #workspaces button,
        .modules-right #workspaces button.focused,
        .modules-right #workspaces button.active {
            border-radius: 0;
            border-bottom: 0px solid transparent;
        }

        #workspaces button.focused,
        #workspaces button.active {
            color: ${base00};
            background-color: ${base0D};
        }

        #custom-audio-in, #custom-audio-out, #custom-wifi {
            padding: 2px 12px;
        }
      '';
  };
}
