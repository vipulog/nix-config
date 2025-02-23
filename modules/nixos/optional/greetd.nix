{
  config,
  lib,
  ...
}: let
  autoLoginCfg = config.customOptions.autoLogin or {};
in {
  services.greetd = {
    enable = true;

    settings = lib.mkIf (autoLoginCfg.enable or false) {
      initial_session.user = autoLoginCfg.username;
    };
  };
}
