{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.wofi.style = with config.lib.stylix.colors.withHashtag;
      mkAfter ''
        #outer-box {
        	padding: 20px;
          border: 3px solid ${base0D};
        }

        #input {
        	border: 0;
        	padding: 8px 12px;
        }

        #scroll {
        	margin-top: 20px;
        }

        #img {
        	padding-right: 8px;
        }

        #text:selected {
          color: ${base00};
        }

        #entry {
        	padding: 6px;
        }

        #entry:nth-child(odd) {
          background-color: ${base00};
        }

        #entry:nth-child(even) {
          background-color: ${base00};
        }

        #entry:selected {
          background-color: ${base0D};
        }

        #input, #entry:selected {
          border-radius: 0;
        }
      '';
  };
}
