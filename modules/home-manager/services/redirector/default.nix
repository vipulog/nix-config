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
      defaultSearch = "https://duckduckgo.com/?q={}";

      customBangs = [
        {
          trigger = "hmopt";
          url_template = "https://home-manager-options.extranix.com/?query={{{s}}}";
        }
      ];
    };
  };
}
