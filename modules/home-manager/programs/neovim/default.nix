{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.neovim;
  codecompanionAdaptersLua = builtins.readFile ./codecompanion/adapters.lua;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options.internal.programs.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;

      settings.vim = {
        lsp.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          python.enable = true;
          rust.enable = true;
        };

        telescope.enable = true;
        statusline.lualine.enable = true;
        treesitter.indent.enable = false;
        utility.outline.aerial-nvim.enable = true;

        binds.whichKey = {
          enable = true;
          setupOpts.preset = "helix";
        };

        mini = {
          ai.enable = true;
          animate.enable = false;
          basics.enable = true;
          bracketed.enable = true;
          bufremove.enable = true;
          comment.enable = true;
          completion.enable = true;
          diff.enable = true;
          git.enable = true;
          hipatterns.enable = true;
          icons.enable = true;
          indentscope.enable = true;
          jump.enable = true;
          jump2d.enable = true;
          move.enable = true;
          notify.enable = true;
          operators.enable = true;
          pairs.enable = true;
          splitjoin.enable = true;
          surround.enable = true;
          tabline.enable = true;
          trailspace.enable = true;
          visits.enable = true;
        };

        assistant.codecompanion-nvim = {
          enable = true;
          setupOpts = {
            adapters = lib.generators.mkLuaInline codecompanionAdaptersLua;
            strategies = {
              chat.adapter = "gemini";
              inline.adapter = "gemini";
              cmd.adapter = "gemini";
            };
            opts.send_code = true;
            display.chat.auto_scroll = true;
          };
        };
      };
    };
  };
}
