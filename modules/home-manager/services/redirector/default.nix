{
  inputs,
  inputs',
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.services.redirector;
in {
  imports = [inputs.redirector.homeManagerModules.redirector];

  options.internal.services.redirector = {
    enable = mkEnableOption "redirector";
  };

  config = mkIf cfg.enable {
    services.redirector = {
      enable = true;
      package = inputs'.redirector.packages.redirector;
      settings = {
        default_search = "https://duckduckgo.com/?q={}";
        search_suggestions = "https://search.brave.com/api/suggest?q={}";
        bangs = [
          {
            trigger = "hmopt";
            url_template = "https://home-manager-options.extranix.com/?query={{{s}}}";
          }
        ];
      };
    };
  };
}
