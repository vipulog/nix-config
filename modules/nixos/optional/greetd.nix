{
  config,
  lib,
  ...
}: let
  autoLoginCfg = config.autoLogin;
in {
  options.autoLogin = {
    enable = lib.mkEnableOption "Enable automatic login";

    username = lib.mkOption {
      type = lib.types.str;
      description = "User to automatically login";
      example = "john_doe";
    };
  };

  config.services.greetd = {
    enable = true;

    settings = {
      initial_session = lib.mkIf autoLoginCfg.enable {
        user = "${autoLoginCfg.username}";
      };
    };
  };
}
