{
  config,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.wofi = {
      enable = true;

      style = with config.lib.stylix.colors.withHashtag;
        mkAfter (
          replaceStrings ["COLOR_BASE00" "COLOR_BASE0D"] [base00 base0D] (
            readFile ./style.css.in
          )
        );

      settings = {
        show = "drun";
        prompt = "Apps";

        width = "540px";
        height = "360px";
        location = 0;
        orientation = "vertical";
        line_wrap = false;
        dynamic_lines = false;

        allow_markup = true;
        allow_images = true;
        image_size = 24;

        exec_search = false;
        hide_search = false;
        parse_search = false;
        insensitive = true;

        hide_scroll = true;
        no_actions = true;
        sort_order = "default";
        gtk_dark = true;
        filter_rate = 100;

        key_exit = "Escape";
      };
    };
  };
}
