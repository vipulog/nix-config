{
  lib,
  config,
  inputs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.services.redirector;
in {
  imports = [inputs.redirector.homeModules.default];

  options.${namespace}.services.redirector = {
    enable = lib.mkEnableOption "redirector";
  };

  config = lib.mkIf cfg.enable {
    services.redirector = {
      enable = true;

      settings = {
        port = 3030;
        default_search = "https://duckduckgo.com/?q={}";
        search_suggestions = "https://search.brave.com/api/suggest?q={}";

        bangs = [
          {
            trigger = "hmopt";
            url_template = "https://home-manager-options.extranix.com/?query={{{s}}}";
          }
          {
            trigger = "noog";
            url_template = "https://noogle.dev/q?term={{{s}}}";
          }
        ];
      };
    };
  };
}
